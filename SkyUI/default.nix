{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "SkyUI";
  version = "12604-5-2SE";
  
  src = pkgs.callPackage downloader {
    mod_id="12604";
    file_id="35407";
    sha256 = "sha256-UFiI/Lgp2c9WsEATduqkUISPqGKeJmyi1gaMnhNu2Nk="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    cp -r SkyUI_SE.* $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim SkyUI";
    license = licenses.unfree;
  };
}

