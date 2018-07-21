{ stdenv, lib, buildEnv, futhark, extractFut }:

{ name
, src
, futharkDeps ? []
, buildInputs ? []
, passthru ? {}
, ... }@attrs:

let

  path = buildEnv {
    name = "futhark-path-${name}";
    paths = futharkDeps ++ lib.optional (! lib.inNixShell) src;
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
      nix-store -v --add-root path --indirect -r ${path}
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
    inherit path;
  } // passthru;

} // builtins.removeAttrs attrs [
  "name" "src" "futharkDeps" "buildInputs" "passthru"
])
