{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "SkyUI";
  version = "12604-5-2SE";
  src = fetchurl {
    url = "http://localhost:8000/SkyUI_5_2_SE-${version}.7z";
    sha256 = "sha256-U3Xg6RBR9XrUY9/jQSu6WKu5dfhHmpaN2dTl0ylDFmI="; # You need to replace this with the actual hash of the downloaded file.
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

