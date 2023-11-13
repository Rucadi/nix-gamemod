{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "skse64";
  version = "2_02_03";
  src = fetchurl {
    url = "https://skse.silverlock.org/beta/skse64_${version}.7z";
    sha256 = "073hd8814qkhhcywy241mjqyjf7l7niwqy1zg301da19qsycxnag"; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-modded
    cp -r sks*/* $out/skyrim-modded/
    rm -rf $out/skyrim-modded/src
  '';

  meta = with lib; {
    description = "Skyrim Script Extender 64";
    license = licenses.unfree;
  };
}

