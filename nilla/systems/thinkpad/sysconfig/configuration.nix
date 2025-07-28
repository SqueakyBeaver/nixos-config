{
  config,
  pkgs,
  lib,
  project,
  ...
}: {
  imports = [
    ./boot.nix
    ./cli.nix
    ./hardware-configuration.nix
    ./plymouth.nix
    ./power.nix
    ./users.nix
    ./networking.nix
    ./rebinds.nix
    ./sysutils.nix
  ];
  
  time.timeZone = "America/Chicago";
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

  networking.hostName = "thinkpad";
  users.defaultUserShell = pkgs.zsh;
}
