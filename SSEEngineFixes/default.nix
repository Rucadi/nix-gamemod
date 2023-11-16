{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
}:
let
  inherit (pkgs) lib libarchive stdenv p7zip;
in
stdenv.mkDerivation rec {
  pname = "SSEENgineFixes";
  version = "";
  
  src = pkgs.buildEnv {
     name = "combine";
     paths = [
          (pkgs.callPackage downloader {
          mod_id="17230";
          file_id="321815";
          sha256 = "sha256-dM/5rQZpTPgmLfEgvz2W2Bv5SnH+f+akkaDQ8erQj+w="; # You need to replace this with the actual hash of the downloaded file.
        })
         (pkgs.callPackage downloader {
          mod_id="17230";
          file_id="181171";
          sha256 = "sha256-qaXJKwaNVE9o1a51TwRTiO/RBV20jznS+4jRJJxnCQ4="; # You need to replace this with the actual hash of the downloaded file.
        })];
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    ##patch tbbmalloc out

    echo UseTBBMalloc=false >> data/skse/plugins/EngineFixes.toml
    
    mv data/skse/plugins data/skse/Plugins
    mv data/skse data/SKSE
    mv data/* $out/skyrim-se-modded/Data
    rm -rf data
    mv *dll $out/skyrim-se-modded
    
  '';

  meta = with lib; {
    description = "AddressLibrarySKSEPlugins";
    license = licenses.unfree;
  };
}

