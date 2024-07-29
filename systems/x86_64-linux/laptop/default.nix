{
  self,
  inputs,
  lib,
  homeImports,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  users.groups.beaver = {};
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky beaver";
    group = "beaver";
    extraGroups = ["networkmanager" "wheel" "gamemode"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  boot.resumeDevice = "/dev/disk/by-partlabel/root";
  # FIXME: Change if drive chages or anything
  boot.kernelParams = ["resume_offset=23279616"];

  networking.hostName = "toaster-oven-of-death";

  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    toaster-oven-of-death = nixosSystem {
      inherit specialArgs;
      modules = [
        "${mod}/programs"
        "${mod}/services"
        {
          home-manager = {
            users.beaver.imports = homeImports."beaver@laptop";
            extraSpecialArgs = specialArgs;
          };
        }

        "${mod}"

        ./modules
        ./system
      ];
    };
  };
}
