{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods
}:
let
  inherit (pkgs) lib libarchive stdenv p7zip;
in
stdenv.mkDerivation rec {
  pname = "SksePlugins";
  version = "";
  
  src = pkgs.callPackage downloader {
    mod_id="32444";
    file_id="320262";
    sha256 = "sha256-pWo97iVa4CX5JWg50GPwAvlK/9wsKOIYvqG45QPUfoI="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data
    cp -r * $out/skyrim-se-modded/Data/
    rm $out/skyrim-se-modded/Data/env-vars
  '';

  meta = with lib; {
    description = "AddressLibrarySKSEPlugins";
    license = licenses.unfree;
  };
}

