{ stdenv, lib, buildEnv, futhark, futharkSrc }:

{ name
, src
, futharkDeps ? []
, buildInputs ? []
, passthru ? {}
, ... }@attrs:

let

  path = futharkSrc {
    inherit name src futharkDeps;
    # In a nix-shell we don't want the installpath to contain an unchangeable
    # source, but use the one in the current directory instead, only deps should
    # be from the installpath in that case
    depsOnly = lib.inNixShell;
  };

in

stdenv.mkDerivation ({
  name = "futhark-${name}";
  src = path;
  buildInputs = [ futhark ] ++ buildInputs;

  buildPhase = ''
    runHook preBuild
    futhark-c -v ${name}.fut
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ${name} $out/bin
    runHook postInstall
  '';

  shellHook = ''
    installpath() {
      # Prevents garbage collection, and allows for troubleless removal with rm
      nix-store -v --add-root path --indirect -r ${path}
      # Bring the top-level files/dirs into the current directory
      ln -fs path/* .
    }
    uninstallpath() {
      for f in path/*; do
        rm "''${f#path/}"
      done
      rm path
    }
  '';

  passthru = {
    # Allows building just the path via `nix-build -A path`
    inherit path;
  } // passthru;

} // builtins.removeAttrs attrs [
  "name" "src" "futharkDeps" "buildInputs" "passthru"
])
