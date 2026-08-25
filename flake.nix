{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "git+https://git.lix.systems/lix-project/lix?ref=main";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };

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
    tinted-themes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    pixelflasher = {
      url = "github:badabing2005/PixelFlasher";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    commonModules = [
      ./systems/common

      inputs.lix-module.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-bak";
          overwriteBackup = true;

          extraSpecialArgs = {inherit inputs;};
        };
      }
      {
        nixpkgs = {
          config.allowUnfree = true;

          overlays = [
            (import ./packages/overlays.nix {inherit inputs;})
          ];
        };
      }
    ];

    mkConfiguration = attrs:
      nixpkgs.lib.nixosSystem (nixpkgs.lib.mergeAttrsConcatenateValues {
          specialArgs = {inherit inputs;};
          modules = commonModules;
        }
        attrs);
  in {
    nixosConfigurations = {
      thinkpad = mkConfiguration {
        modules = [
          ./systems/thinkpad
          # inputs.stylix.nixosModules.stylix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          {
            home-manager.users.beaver = ./homes/beaver;
          }
          {
            nixpkgs.overlays = [
              inputs.niri.overlays.niri
            ];
          }
        ];
      };

      homelab = mkConfiguration {
        modules = [
          ./systems/homelab
          ./systems/common/desktop/kde.nix
          inputs.disko.nixosModules.default
          {
            home-manager.users.otter = ./homes/otter;
          }
        ];
      };
    };
  };
}
