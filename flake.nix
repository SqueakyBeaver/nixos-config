{
  description = "A very basic flake";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun.url = "github:anyrun-org/anyrun";

    # Hypr
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.hyprlang.follows = "hyprland/hyprlang";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
      inputs.systems.follows = "hyprland/systems";
    };

    # Widgets
    ags = {
      url = "github:Aylur/ags";
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
  };

  /*
    outputs = { self, nixpkgs, ... } @ inputs:
    let
      inherit (self) outputs;

      # systems = [ "x86_64-linux" ];

      # forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./home/profiles
        ./hosts
        ./modules
        # ./pkgs
      ];

      flake =  {
        packages.x86_64-linux = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;
      };

      # TODO: Make it more like this 
      # https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix
    };
    */


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
    };
}
