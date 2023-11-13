{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; # Or just `nixpkgs` if you want to use the registry
  };

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      with import "${nixpkgs}" {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

    pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (pkgs.callPackage ./SkyrimSE { })
        (pkgs.callPackage ./SKSE { })
        (pkgs.callPackage ./SkyUI { })
      ];
      ignoreCollisions= true;
    };
  };
}