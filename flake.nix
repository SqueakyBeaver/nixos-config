{
  # TODO: Go to flake-utils maybe?
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Colors
    matugen = {
      url = "github:InioX/matugen/module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nixvim-config = {
      url = "github:dc-tec/nixvim";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    clan-core = {
      url = "git+https://git.clan.lol/clan/clan-core";
      # Don't do this if your machines are on nixpkgs stable.
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    lix-module,
    home-manager,
    nixos-hardware,
    auto-cpufreq,
    flake-parts,
    clan-core,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({
      self,
      pkgs,
      ...
    }: {
      systems = [];

      imports = [clan-core.flakeModules.default];

      clan = {
        directory = self;
        specialArgs = {};
        inventory.meta.name = "beaver-dam";

        machines = {
          # My main machine/laptop; my baby
          # My thinkpad
          shadow = {
            nixpkgs.hostPlatform = "x86-64_linux";
            imports = ["./machines/shadow/configuration.nix"];
          };

          # not the fastest, but a place where i tinker and self-host stuff
          # My old laptop
          tails = {
            nixpkgs.hostPlatform = "x86-64_linux";
            imports = ["./machines/tails/configuration.nix"];
          };
        };
      };
    });
  # nixosConfigurations = clan.nixosConfigurations;
  # inherit (clan) clanInternals;
}
# inputs.snowfall-lib.mkFlake {
#   inherit inputs;
#   src = ./.;
#   systems.modules.nixos = with inputs; [
#     lix-module.nixosModules.lixFromNixpkgs
#     sops-nix.nixosModules.sops
#     auto-cpufreq.nixosModules.default
#   outputs-builder = channels: {
#     formatter = channels.nixpkgs.alejandra;
#   };
#   channels-config = {
#     allowUnfree = true;
#   };
# };

