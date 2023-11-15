{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "Alternate Start";
  version = "";
  src = pkgs.callPackage downloader {
    mod_id="272";
    file_id="400276";
    sha256 = "sha256-9bGjs2KCZifktMCP2Jmhk54srFcsOE6XquVHiZg/oUc="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "AlternateStart";
    license = licenses.unfree;
  };
}

