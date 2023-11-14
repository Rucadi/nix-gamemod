{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "Alternate Start";
  version = "";
  src = fetchurl {
    url = "http://localhost:8000/Alternate%20Start%20-%20Live%20Another%20Life-272-4-2-0-1687559307.7z";
    sha256 = "sha256-EUwXRx3dyfyAwyQYstXIFmDsaEsQGbicQ+cXStm+V04="; # You need to replace this with the actual hash of the downloaded file.
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

