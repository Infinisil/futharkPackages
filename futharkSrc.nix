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

buildEnv {
  name = "futhark-${name}-path";
  paths = futharkDeps ++ lib.optional (!depsOnly) futSrc;
}
