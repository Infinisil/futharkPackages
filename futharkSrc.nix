{ lib, buildEnv, extractFut }:

{ name
, src
, root ? "."
, futharkDeps ? []
, depsOnly ? false
}:

let
  futSrc = extractFut {
    name = "futhark-${name}-src";
    inherit src root;
  };
in

# Builds an environment where all dependencise have been combined into a single
# path
buildEnv {
  name = "futhark-${name}-path";
  paths = futharkDeps ++ lib.optional (!depsOnly) futSrc;
}
