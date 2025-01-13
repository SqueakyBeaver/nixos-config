{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "games";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Game module";
    optimize = lib.mkEnableOption ''
      set the same sysctl settings as are set on SteamOS
    '';
    steam.enable = mkEnableOption "Steam";
    lutris.enable = mkEnableOption "Lutris";
  };

  config = mkIf cfg.enable {
    programs.steam = mkIf cfg.steam.enable {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      extraCompatPackages = [
        pkgs.proton-ge-bin
        pkgs.dotnet-sdk # For tmodloader
      ];
    };

    environment.systemPackages = mkIf cfg.lutris.enable [
      pkgs.lutris
    ];

    hardware.graphics.enable32Bit = cfg.lutris.enable;

    programs.gamemode.enable = true;

    # last cheched with https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/steamos-customizations-jupiter-20240219.1-2-any.pkg.tar.zst
    boot.kernel.sysctl = mkIf cfg.optimize {
      # 20-shed.conf
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      # 20-net-timeout.conf
      # This is required due to some games being unable to reuse their TCP ports
      # if they're killed and restarted quickly - the default timeout is too large.
      "net.ipv4.tcp_fin_timeout" = 5;
      # 30-vm.conf
      # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
      # see comment in include/linux/mm.h in the kernel tree.
      "vm.max_map_count" = 2147483642;
    };
  };
}
