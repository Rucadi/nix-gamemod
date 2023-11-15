{ pkgs ? import <nixpkgs> {} ,
  downloader ? ../nexusmods}:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "USSEP";
  version = "";

  src = pkgs.callPackage downloader {
    mod_id="266";
    file_id="392477";
    sha256 = "sha256-pjavXj0UjSPUiSwTzCbhc0WNhuKyHKJZG/9oGXaIkFk="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim USSEP";
    license = licenses.unfree;
  };
}

