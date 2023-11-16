{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
}:
let
  inherit (pkgs) lib libarchive stdenv p7zip parallel rsync;
in
stdenv.mkDerivation rec {
  pname = "SKYRIM202X";
  version = "";
  
  src = pkgs.buildEnv {
     name = "combine";
     paths = [
          (pkgs.callPackage downloader {
          mod_id="2347";
          file_id="321878";#-Skyrim 202X 9.0 - Architecture PART 1
          sha256 = "sha256-V9vwDcQfKo65FRps7kLpPm7POv+8wb+4NzpGwwvGM2g="; # You need to replace this with the actual hash of the downloaded file.
        })
         (pkgs.callPackage downloader {
          mod_id="2347";
          file_id="321906";#-Skyrim 202X 9.0 - Landscape PART 2
          sha256 = "sha256-shoXBBdA5H9cplkY978JhLV4QaCgqBKrmxwM2pC5Kvk="; # You need to replace this with the actual hash of the downloaded file.
        })
         (pkgs.callPackage downloader {
          mod_id="2347";
          file_id="322212";#-Skyrim 202X 9.0.1 - Other PART 3
         sha256 = "sha256-FCoDfcEr9CWJjKLzhHbGeI6zWyCJQeamRdrsZI2MHMg="; # You need to replace this with the actual hash of the downloaded file.
        })        
         (pkgs.callPackage downloader {
          mod_id="2347";
          file_id="436153";#- Skyrim 202X 9.0 to 9.7.1 Update
          sha256 = "sha256-8o8GFWo6AwxrleMCHhTr60VNxvvPsOYMoIkrAEHngeo="; # You need to replace this with the actual hash of the downloaded file.
        })
        ];
  };

  nativeBuildInputs = [ libarchive p7zip parallel rsync];
  phases = [ "unpackPhase" "installPhase"]; 

  unpackPhase = ''
  #first unpack everything minus the update, then the update.
  find ${src} | grep 7z | grep -v Update | parallel '7z x -aoa {} || true'
  find ${src} | grep 7z | grep Update | parallel '7z x -aoa {} || true'
  '' ;
   

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
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

