{ pkgs ? import <nixpkgs> {} }:
pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (pkgs.callPackage ./SkyrimAE { })
        (pkgs.callPackage ./SKSE-AE { })
        (pkgs.callPackage ./USSEP { })
        (pkgs.callPackage ./Alternate-Start { })
        (pkgs.callPackage ./SkyUI { })
        (pkgs.callPackage ./AdressLibrarySKSEPlugins { })
        (pkgs.callPackage ./SSEEngineFixes { })
        (pkgs.callPackage ./SMIM { })
        (pkgs.callPackage ./SKYRIM202X { })
      ];
      ignoreCollisions= true;
    }