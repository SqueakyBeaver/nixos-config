{ pkgs, self, inputs, lib, ... }:
let
in {
  imports = [
    ./hardware-configuration.nix
  ];

  users.groups.beaver = { };
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky beaver";
    group = "beaver";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];


  networking.hostName = "toaster-oven-of-death";
}
