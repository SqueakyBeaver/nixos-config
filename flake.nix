{
  # TODO: Go to flake-utils maybe?
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
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

    # nix-index-db = {
    #   url = "github:Mic92/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # grub2-themes = {
    #   url = "github:vinceliuice/grub2-themes";
    # };

    nixvim-config = {
      url = "github:dc-tec/nixvim";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    lix-module,
    home-manager,
    # grub2-themes,
    ...
  }:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      systems.modules.nixos = with inputs; [
        lix-module.nixosModules.lixFromNixpkgs
        # grub2-themes.nixosModules.default
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
