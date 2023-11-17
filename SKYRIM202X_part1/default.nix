{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
}:
let
  inherit (pkgs) lib libarchive stdenv p7zip parallel rsync;
in
stdenv.mkDerivation rec {
  pname = "SKYRIM202X part 1";
  version = "";
  
  src = pkgs.callPackage downloader {
          mod_id="2347";
          file_id="321878";#-Skyrim 202X 9.0 - Architecture PART 1
          sha256 = "sha256-V9vwDcQfKo65FRps7kLpPm7POv+8wb+4NzpGwwvGM2g="; # You need to replace this with the actual hash of the downloaded file.
        };

  nativeBuildInputs = [ libarchive p7zip parallel rsync];
  phases = [ "unpackPhase" "installPhase"]; 

  unpackPhase = ''
    7z x $src
  '' ;
   

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    mkdir -p data
    mkdir -p DATA
    rsync -av \
      'data'/* \
      'DATA'/* \
      $out/skyrim-se-modded/Data/
    
  '';

  meta = with lib; {
    description = "SKYRIM202X";
    license = licenses.unfree;
  };
}

