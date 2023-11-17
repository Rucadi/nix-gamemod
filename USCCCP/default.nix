{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "Skyrim Unofficial Creation Club Content Patches";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="18975";
    file_id="414520";
    sha256 = "sha256-Zd33TWLEhdj28CSeAfUMrTXlwxfarLSgtX4VooRqRt8="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x -aoa $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    rm env-vars
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim Unofficial Creation Club Content Patches";
    license = licenses.unfree;
  };
}