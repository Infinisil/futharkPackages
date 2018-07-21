{ pkgs, lib, haskellPackages }:

let

  scope = self: with self; {

    # The futhark compiler
    inherit (haskellPackages) futhark;

    # A convenience function to extract .fut files from a source
    extractFut = callPackage ./extractFut.nix {};

    futharkSrc = callPackage ./futharkSrc.nix {};

    # A function to build a package
    buildFuthark = callPackage ./buildFuthark.nix {};

    # Libraries, all just a single .fut file in this case
    distance = callPackage ./distance.nix {};
    least_squares = callPackage ./least_squares.nix {};
    price_european_calls = callPackage ./price_european_calls.nix {};
    heston = callPackage ./heston.nix {};

  };

  packages = lib.makeScope (extra: lib.callPackageWith (pkgs // extra)) scope;

in packages
