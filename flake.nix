{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/x86_64-linux";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager/trunk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    keyd = {
      url = "github:rvaiya/keyd";
      flake = false;
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    valent = {
      url = "github:andyholmes/valent";
      flake = false;
    };
    spotx-bash = {
      url = "github:Spotx-official/spotx-bash";
      flake = false;
    };
    pixelflasher = {
      url = "github:badabing2005/PixelFlasher";
      flake = false;
    };
    # npins.url = "github:andir/npins";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./systems/common
          ./systems/common/desktop/kde.nix
          ./systems/thinkpad
          inputs.chaotic.nixosModules.default
          inputs.lix-module.nixosModules.lixFromNixpkgs
          inputs.niri.nixosModules.niri
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          inputs.home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.beaver = ./homes/beaver;

            home-manager.extraSpecialArgs = {inherit inputs;};
          }
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [
              (import ./packages/overlays.nix {inherit inputs;})
            ];
          }
        ];
      };

      homelab = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./systems/homelab
          ./systems/common
          ./systems/common/desktop/kde.nix
          inputs.lix-module.nixosModules.lixFromNixpkgs
          inputs.sops-nix.nixosModules.sops
          inputs.disko.nixosModules.default
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.otter = ./homes/otter;

            home-manager.extraSpecialArgs = {inherit inputs;};
          }

          {nixpkgs.config.allowUnfree = true;}
        ];
      };
    };
  };
}
