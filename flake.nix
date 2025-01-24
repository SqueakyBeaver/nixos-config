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
  };

  outputs = inputs @ {
    nixpkgs,
    lix-module,
    home-manager,
    nixos-hardware,
    auto-cpufreq,
    ...
  }:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      systems.modules.nixos = with inputs; [
        lix-module.nixosModules.lixFromNixpkgs
        sops-nix.nixosModules.sops
        auto-cpufreq.nixosModules.default
      ];

      snowfall = {
        namespace = "timber";

        meta.name = "timber";
        meta.title = "Currently a very not good NixOS config";
      };

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };

      channels-config = {
        allowUnfree = true;
      };
    };
}
