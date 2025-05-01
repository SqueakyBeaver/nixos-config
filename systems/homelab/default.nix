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
    ./users
    # ./plymouth
  ];

  timber = {
    audio.enable = true;
    desktop.plasma.enable = true;
    xdg.enable = true;
    virtualisation.enable = true;
    printing = {
      enable = true;
      openFirewall = true;
    };
    cloudflared = {
      enable = true;
    };
  };

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
