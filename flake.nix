{
  # TODO: Go to flake-utils maybe?
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hmm = {
      url = "git+https://codeberg.org/SqueakyBeaver/hmm-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    lix-module,
    home-manager,
    nixos-hardware,
    nixvim,
    sops-nix,
    nix-index-db,
    niri,
    stylix,
    ...
  }:
    flake-utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = [
        "x86_64-linux"
      ];

      channelsConfig = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "fluffychat-linux-1.26.0"
          "olm-3.2.16"
        ];
      };

      sharedOverlays = [
        lix-module.overlays.lixFromNixpkgs
        self.overlay
      ];

      hostDefaults.modules = [
        sops-nix.nixosModules.sops
        niri.nixosModules.niri
        stylix.nixosModules.stylix

        ./modules/nixos
      ];

      hosts.thinkpad = {
        modules = [
          # TODO thinkpad module
          ./systems/thinkpad
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

          home-manager.nixosModules.home-manager
          {
            home-manager.users.beaver = ./homes/${"beaver@thinkpad"};

            home-manager.extraSpecialArgs = {inherit inputs;};

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
          }
        ];
      };

      overlay = import ./overlays;
    };
}
