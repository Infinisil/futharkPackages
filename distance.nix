{ futharkSrc, fetchFromGitHub }:
futharkSrc {
  name = "distance";
  src = fetchFromGitHub {
    owner = "diku-dk";
    repo = "futhark-benchmarks";
    rev = "3f6f7a547e33b0c17aa892671090c5d0efec5163";
    sha256 = "1pwgdav34csmqj3dfb3rn3y2a741z5f3pqs264fcv6wll06ficz0";
  };
  root = "misc/heston/distance.fut";
}
