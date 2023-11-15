{ 
  pkgs ? import <nixpkgs> {} 
  ,
  game_id ? "1704"#skyrim se default
  ,
  mod_id ? ""
  ,
  file_id ? ""
  ,
  sha256 ? ""
  ,
  game_name ? "skyrimspecialedition" #skyrim se default
  ,
  cookie ? ""
}:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper;
in


stdenv.mkDerivation rec {
  
  nativeBuildInputs = [pkgs.jq pkgs.curl pkgs.cacert pkgs.gnused];
  SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

  pname = "NexusDownload";
  requiredInputs = [ "game_id" "mod_id" "file_id" "game_name" ];

  impureEnvVars = "cookie";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = sha256;

  version = "1";
  buildInputs = [ (pkgs.writeText "envars.srcsh" ''
                                                export cookie='${cookie}'
                                                export game_id=${game_id}
                                                export mod_id=${mod_id}
                                                export file_id=${file_id}
                                                export game_name=${game_name}
                                                '') ];
  shellHook = ''
    source $(cat $PWD/envars.srcsh)
  '';
  preFixup = ''
    # Remove the cookie after it's no longer needed
    rm $out/envars.srcsh
    rm $out/env-vars
  '';
  builder = ./downloadFromNexus.sh;
  dontUnpack = true;
  meta = with lib; {
    description = "nexus downloader";
    license = licenses.mit;
  };

  passthru = {
    # Use builtins.readFile to read the contents of the file and pass it through
    fileContent = builtins.readFile ./url;
  };

}


