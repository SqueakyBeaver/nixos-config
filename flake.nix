{

  # TODO: Go to flake-utils maybe?
  description = "A very basic flake";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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

    nixvim = {
      url = "github:nix-community/nixvim";
      # url = "github:mikaelfangel/nixvim-config"; # nixvim config based on AstroVim
      inputs.nixpkgs.follows = "nixpkgs"; # Causes an error right now
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      mkSystem = { username, hostname, arch } @ sysCfg: {
        ${hostname} = nixpkgs.lib.nixosSystem {
          system = arch;
          specialArgs = { inherit inputs sysCfg; };
          modules = [
            ./hosts/${hostname}

            ./modules
            ./system
            home-manager.nixosModules.home-manager

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs sysCfg; };
                users.${username}.imports = [
                  ./home
                ];
              };
            }
          ];
        };
      };
      mkHome = { username, hostname } @ sysCfg: {
        "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs sysCfg; };
          modules = [
            # > Our main home-manager configuration file <
            ./hhome
          ];
        };

      };

      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations = mkSystem
        {
          username = "beaver";
          hostname = "laptop";
          arch = "x86_64-linux";
        };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake <dir>#your-username@your-hostname'
      homeConfigurations = mkHome
        {
          username = "beaver";
          hostname = "laptop";
        };

      packages.x86_64-linux = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.zsh
        ];
      };
    };
}

