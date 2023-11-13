{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "SkyrimSE";
  version = "SkyrimSEVersion";
  dontPatch = true;

  src = fetchurl {
    url = "http://localhost:8000/skyrimse.tar.gz";
    sha256 = "sha256-2c5/HXRK9iQ/O3q2NS8U1ULWCi1C73rXpNMipU2i6o8="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = ''
    mkdir -p $out
    tar  xf $src --directory $out 
    '';

  installPhase = ''
    mv $out/"Skyrim Special Edition" $out/skyrim-se-modded
  '';

  phases = [ "unpackPhase" "installPhase"]; 
  meta = with lib; {
    description = "SkyrimSE";
    license = licenses.unfree;
  };
}

