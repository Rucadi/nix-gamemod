{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
}:
let
  inherit (pkgs) lib libarchive stdenv p7zip parallel rsync;
in
pkgs.buildEnv rec {
    name= "ff";
      paths = [
      (pkgs.callPackage ../SKYRIM202X_part3 { })
      (pkgs.callPackage ../SKYRIM202X_part2 { })
      (pkgs.callPackage ../SKYRIM202X_part1 { })
    ];
    ignoreCollisions= true;

}

