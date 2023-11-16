{ pkgs ? import <nixpkgs> {},
  downloader ? ../nexusmods,

  }:
let
  inherit (pkgs) lib fetchurl libarchive stdenv p7zip makeWrapper rsync;
in
stdenv.mkDerivation rec {
  pname = "SMIM";
  version = "";
  src = pkgs.callPackage downloader {
    mod_id="659";
    file_id="59069";
    sha256 = "sha256-pbd8dX6IuVZoE3KKduylIbiNG1eejIZhn1PV3DrYkIs="; # You need to replace this with the actual hash of the downloaded file.
  };

  nativeBuildInputs = [ libarchive p7zip rsync];

  unpackPhase = "7z x $src";

  installPhase = ''
    mkdir -p $out/skyrim-se-modded/Data/
    rsync -av \
        '00 Core'/* \
        '01 Furniture'/* \
        '02 SMIM Rustic Barrel Textures Animations'/* \
        '03 Food'/* \
        '04 Farmhouse 3D Ropes No Fade (Best)'/* \
        '05 Chains 3D - Misc'/* \
        '06 Chains 3D - Signs'/* \
        '07 Chains 3D - Whiterun'/* \
        '08 Chains 3D - Pull Levers Small Rings'/* \
        '09 Dwemer Clutter'/* \
        '10 Nordic Tables and Benches'/* \
        '11 Bridges Old Stonework'/* \
        '12 Whiterun Doors'/* \
        '13 Lanterns'/* \
        '14 Stockade 3D Ropes'/* \
        '15 Clothing Fixes'/* \
        '16 Tankard Bright Brushed Metal'/* \
        '17 Nordic Catacombs Skeletal Remains'/* \
        '18 Farmhouse Woven Fence Dense'/* \
        '19 Smelter'/* \
        '20 Furniture Skyrim HD Appearance'/* \
        '21 Dwemer Animated Lifts SE'/* \
        '22 Solitude Docks Ropes SE'/* \
        '23 Tomato Pure Red without Blemish'/* \
        '25 Solitude Gate Doors'/* \
        '26 Human Skull Fixes'/* \
        '27 Hawk'/* \
        '28 Hawk Dragonborn Fix'/* \
        '29 Raven Rock 3D Ropes'/* \
        '30 Rocks - Generic'/* \
        '31 Rocks - Blackreach'/* \
        '32 Rocks - Mountains'/* \
        '33 Orc Longhouse'/* \
        '35 Shack Kit'/* \
        '36 Shack Kit Dragonborn'/* \
        '38 Riften 3D Ropes Better Ropes Texture'/* \
        '39 Dungeons 3D Ropes and Glorious Scaffolding'/* \
        '40 Furniture Chests'/* \
        '41 Draugr Corpses'/* \
        '42 Furniture Noble'/* \
        '43 Whiterun Castle Wood Carvings Celtic'/* \
        '44 Poor Coffin Custom Texture'/* \
        '45 Hanging Rings'/* \
        '46 Carriage Seats and Fixes'/* \
        '47 Juniper Tree'/* \
        '48 Juniper Tree Excessive Polycount Version'/* \
        '49 Tundra Tree'/* \
        '51 Dawnguard Soulcairn Bone Piles (More Bones)'/* \
        '54 Imperial Jail Brighter Metal'/* \
        '55 Windmills Base Vanilla Version Sails'/* \
        '57 Ruins Sarcophagus'/* \
        '58 Jewelry Rings'/* \
        '59 Jewelry Rings CCO Remade or Jewelcraft Patch'/* \
        '60 Hearthfires Stuff'/* \
        '61 Bowl Ingredients'/* \
        '70 Rabbit'/* \
        '71 Candelabras Sconces Walltorches'/* \
        '72 Chandeliers'/* \
        '73 Chandeliers No 3D Chains Addon'/* \
        '75 Dungeons Cliffs Snow Skirts'/* \
        '81 Half-Sized Furniture Skyrim HD Appearance'/* \
        '84 Half-Sized Textures Tankard Bright Brushed Metal'/* \
        '90 Ultra-Sized Textures'/* \
        '95 Merged ESP SE All'/* \
        $out/skyrim-se-modded/Data/
  '';

  meta = with lib; {
    description = "Statich Mesh";
    license = licenses.unfree;
  };
}

