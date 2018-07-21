# Futhark Packages

See https://github.com/infinisil/futharknixdemo

This is a small artificial packagification of https://github.com/diku-dk/futhark-benchmarks/tree/master/misc/heston

Main files are:

- `default.nix` - scope definition of the package set (and utils)
- `buildFuthark.nix` - definition of a function to build futhark packages
- `futharkSrc.nix` - builder for combining dependencies into a single path

The `heston.nix` file uses 3 other packages as a dependency. This heston package is then used by the futharknixdemo repository.

See the comments in the files as well.
