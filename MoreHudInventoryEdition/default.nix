{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "More Hud Inventory Edition";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="18619";
    file_id="336167";
    sha256 = "sha256-fS5BIpCoXNVNZGykvIEEppZJwc0lg1VJzBJj7lN5tVk="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x -aoa $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    rm env-vars
    cp -r Data/* $out/skyrim-se-modded/Data
  '';

  meta = with lib; {
    description = "More Hud Inventory Edition";
    license = licenses.unfree;
  };
}