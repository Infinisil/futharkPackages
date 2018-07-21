{ stdenv, runCommand, rsync }:
{ name, src, root ? "." }:

stdenv.mkDerivation {
  inherit name src root;
  buildInputs = [ rsync ];
  installPhase = ''
    sourceRoot="$src/$root"
    if [ -f "$sourceRoot" ]; then
      mkdir $out
      cp "$sourceRoot" "$out"
    else
      rsync -rvm --include="*/" --include="*.fut" --exclude="*" \
        "$sourceRoot/" "$out"
    fi
  '';
}
