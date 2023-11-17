

{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "More Informative Console";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="19250";
    file_id="319359";
    sha256 = "sha256-kH7vUub4wyBbNGI+aWTUB7j+q707HJjKg5yXwX1LXTw="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x -aoa $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    rm env-vars
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim More Informative Console";
    license = licenses.unfree;
  };
}

