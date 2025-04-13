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
    ./plymouth
    lenovo-thinkpad-t14-amd-gen1
  ];

  services.plantuml-server.enable = true;
  # I don't want it auto-started tbh
  systemd.services.plantuml-server.wantedBy = pkgs.lib.mkOverride 0 [];

  environment.systemPackages = [
    pkgs.rocmPackages.rocm-smi # For btop gpu monitoring (hope)
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
    syncthing.enable = true;

    tor = {
      enable = true;
      snowflake.enable = true;
    };

    ollama = {
      enable = false;
      accel = "rocm";
    };
  };

  # Worth a shot
  # services.ollama = {
  #   rocmOverrideGfx = "9.0.0";
  # };
  hardware.amdgpu.opencl.enable = true;

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
}
