{ pkgs ? import <nixpkgs> {} }:
pkgs.buildEnv {
      name = "my-packages";
      paths = [
        
        (pkgs.callPackage ./SkyUI { })

        (pkgs.callPackage ./MoreHud { })
        (pkgs.callPackage ./MoreHudInventoryEdition { })
        (pkgs.callPackage ./GhostItemFix { })
        (pkgs.callPackage ./MoreInformativeConsole { })
        (pkgs.callPackage ./BetterMessageBoxControls { })# conflicts with racemenu
        (pkgs.callPackage ./BetterDialogueControls { }) 
        (pkgs.callPackage ./SMIM { })
        (pkgs.callPackage ./SKYRIM202X_full { })
        (pkgs.callPackage ./Alternate-Start { })
        (pkgs.callPackage ./RaceMenu { })
        (pkgs.callPackage ./SSEEngineFixes { })
        (pkgs.callPackage ./AdressLibrarySKSEPlugins { })
        (pkgs.callPackage ./USMPSE { })
        (pkgs.callPackage ./USCCCP { })
        (pkgs.callPackage ./USSEP { })
        (pkgs.callPackage ./SKSE-AE { })

        ### GAME BASE IS FULLY OVERRIDEN ###
        (pkgs.callPackage ./SkyrimAE { })
      ];
      ignoreCollisions= true;
    }