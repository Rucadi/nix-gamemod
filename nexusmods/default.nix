{ 
  pkgs ? import <nixpkgs> {} 
  ,
  game_id ? ""
  ,
  mod_id ? ""
  ,
  file_id ? ""
  ,
  game_name ? ""
  ,
  cookie ? ""
  }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in


stdenv.mkDerivation rec {
  
  nativeBuildInputs = [pkgs.jq pkgs.curl pkgs.cacert pkgs.gnused];
  sha256 = "sha256-xfloXe9NcLCdoU+CjRxtppMAur+yReLnw4JmEnPAQS0="; # You need to replace this with the actual hash of the downloaded file.
  SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

  pname = "NexusDownload";
  requiredInputs = [ "game_id" "mod_id" "file_id" "game_name" "cookie" ];


  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = sha256;

  version = "1";
  builder = ./downloadFromNexus.sh;
  dontUnpack = true;
  meta = with lib; {
    description = "Skyrim SkyUI";
    license = licenses.unfree;
  };

  passthru = {
    # Use builtins.readFile to read the contents of the file and pass it through
    fileContent = builtins.readFile ./url;
  };

}


