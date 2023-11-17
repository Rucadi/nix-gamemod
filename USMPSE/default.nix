{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
 }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in
stdenv.mkDerivation rec {
  pname = "SkyUI";
  version = "12604-5-2SE";
  
  src = pkgs.buildEnv {
     name = "combine";
     paths = [
        (pkgs.callPackage downloader {
        mod_id="49616";
        file_id="427155";
        sha256 = "sha256-PGANvcdolNjBXclO41NZCrFMr/9geVq2o/88XtqXuxc="; # You need to replace this with the actual hash of the downloaded file.
        }
        )
        (pkgs.callPackage downloader {
        mod_id="49616";
        file_id="431376";
        sha256 = "sha256-z9YnQn4Rxu/ngYTrPRrR9JiOIcBwOfPZLAr0439ixg4="; # You need to replace this with the actual hash of the downloaded file.
        }
        )
      ];
    };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x -aoa $src";

  installPhase = ''
    rm env-vars
    mkdir -p $out/skyrim-se-modded/Data
    cp -r * $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Skyrim SkyUI";
    license = licenses.unfree;
  };
}

