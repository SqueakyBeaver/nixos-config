{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot
    ./power
    ./users
    ./plymouth
  ];

  config = {
    audio.enable = true;
    # desktop.plasma.enable = true;
    # xdg.enable = true;
    desktop.niri.enable = true;
    games = {
      enable = true;
      steam.enable = true;
      lutris.enable = true;
      mangohud.enable = true;
    };
    virt = {
      enable = true;
      podman.enable = true;
    };
    printing = {
      enable = true;
      openFirewall = true;
    };
    # syncthing.enable = true;

    services.plantuml-server.enable = true;
    # I don't want it auto-started tbh
    systemd.services.plantuml-server.wantedBy = pkgs.lib.mkOverride 0 [];

    programs.wireshark = {
      enable = false;
      package = pkgs.wireshark-qt;
    };

    services.colord.enable = true;

    environment.systemPackages = [
      pkgs.rocmPackages.rocm-smi # For btop gpu monitoring (hope)
    ];
    hardware.amdgpu.opencl.enable = true;

    services.fwupd.enable = true;

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
  };
}
