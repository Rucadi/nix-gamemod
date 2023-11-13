{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "SkyrimAE";
  version = "SkyrimAEVersion";
  dontPatch = true;

  src = fetchurl {
    url = "http://localhost:8000/SkyrimAE.tar";
    sha256 = "sha256-wk/ZpMAfxM0j3wngjgpc3scS1R/fKzgNKJW/gvDVMJk="; # You need to replace this with the actual hash of the downloaded file.
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
    description = "SkyrimAE";
    license = licenses.unfree;
  };
}

