{
  self,
  inputs,
  lib,
  homeImports,
  pkgs,
  namespace,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot
    ./power
  ];

  users.groups.beaver = {};
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky beaver";
    group = "beaver";
    extraGroups = ["networkmanager" "wheel" "gamemode"];
    # shell = pkgs.zsh;
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

  # networking.hostName = "toaster-oven-of-death";

  timber = {
    audio.enable = true;
    desktop.plasma.enable = true;
    games.enable = true;
    games.optimize.enable = true;
    xdg.enable = true;
    virtualisation.enable = true;
    virtualisation.guest.enable = true;
  };
}
