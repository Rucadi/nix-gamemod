

{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "RaceMenu";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="19080";
    file_id="327229";
    sha256 = "sha256-ZhaW+K4cZ4/kw3hL3oDpftvK4JPVtgLt3iNG8qmtM6k="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    rm env-vars
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim RaceMenu";
    license = licenses.unfree;
  };
}

