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
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
    ];
    
    # shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  timber = {
    audio.enable = true;
    desktop.plasma.enable = true;
    games = {
      enable = true;
      optimize = true;
    };
    xdg.enable = true;
    virtualisation.enable = true;
    printing = {
      enable = true;
      openFirewall = true;
    };
  };
}
