

{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "Better Message Box Controls";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="1428";
    file_id="11023";
    sha256 = "sha256-z60dj4Wc5qAZyBf2s5gOrb01ROfub9nFkSnmIocOXPc="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    rm env-vars
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim Better Message Box Controls";
    license = licenses.unfree;
  };
}

