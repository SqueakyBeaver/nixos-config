{
  # TODO: Go to flake-utils maybe?
  description = "A very basic flake";

  inputs = {
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

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
  };

  # outputs = {
  #   nixpkgs,
  #   lix-module,
  #   home-manager,
  #   ...
  # } @ inputs: let
  #   mkSystem = {
  #     username,
  #     hostname,
  #     arch,
  #   } @ sysCfg: {
  #     ${hostname} = nixpkgs.lib.nixosSystem {
  #       system = arch;
  #       specialArgs = {inherit inputs sysCfg;};
  #       modules = [
  #         ./hosts hostname

  #         ./modules
  #         ./system
  #         home-manager.nixosModules.home-manager
  #         lix-module.nixosModules.default

  #         {
  #           home-manager = {
  #             useGlobalPkgs = true;
  #             useUserPackages = true;
  #             extraSpecialArgs = {inherit inputs sysCfg;};
  #             users.${username}.imports = [
  #               ./home
  #             ];
  #           };
  #         }
  #       ];
  #     };
  #   };
  #   mkHome = {
  #     username,
  #     hostname,
  #   } @ sysCfg: {
  #     "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
  #       pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
  #       extraSpecialArgs = {inherit inputs sysCfg;};
  #       modules = [
  #         # > Our main home-manager configuration file <
  #         ./home username hostname
  #       ];
  #     };
  #   };
  # in {
  #   nixosConfigurations =
  #     mkSystem
  #     {
  #       username = "beaver";
  #       hostname = "laptop";
  #       arch = "x86_64-linux";
  #     };

  #   # Standalone home-manager configuration entrypoint
  #   # Available through 'home-manager --flake <dir>#your-username@your-hostname'
  #   homeConfigurations =
  #     mkHome
  #     {
  #       username = "beaver";
  #       hostname = "laptop";
  #     };

  #   packages.x86_64-linux = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;
  # };

  outputs = inputs @ {
    lix-module,
    home-manager,
    ...
  }:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      systems.modules.nixos = with inputs; [
        lix-module.nixosModules.default
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
