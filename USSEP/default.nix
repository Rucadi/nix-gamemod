{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "USSEP";
  version = "";
  src = fetchurl {
    url = "http://localhost:8000/Unofficial%20Skyrim%20Special%20Edition%20Patch-266-4-2-9a-1685216241.7z";
    sha256 = "sha256-aJGA2oyQnTQCo+rhR8NSGTi3cq3fbtdpNzgdPayW8TE="; # You need to replace this with the actual hash of the downloaded file.
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

