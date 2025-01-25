{
  self,
  inputs,
  lib,
  homeImports,
  pkgs,
  namespace,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    ./hardware-configuration.nix
    ./boot
    ./power
    ./users
    lenovo-thinkpad-t14-amd-gen1
  ];

  timber = {
    audio.enable = true;
    desktop.plasma.enable = true;
    games = {
      enable = true;
      optimize = true;
      steam.enable = true;
      lutris.enable = true;
      mangohud.enable = true;
    };
    xdg.enable = true;
    virtualisation = {
      enable = true;
      podman.enable = true;
    };
    printing = {
      enable = true;
      openFirewall = true;
    };
  };

  services.fwupd.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;

  environment.variables.EDITOR = "code";
}
