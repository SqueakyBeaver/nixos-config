{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
with lib; let
  module = "virtualisation";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Whether to enable virtualisation";
    podman.enable = mkEnableOption "Whether to enable Podman";
  };

  config = {
    programs.virt-manager.enable = cfg.enable;

    virtualisation = {
      libvirtd.enable = cfg.enable;
      spiceUSBRedirection.enable = cfg.enable;

      podman = mkIf cfg.podman.enable {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
        autoPrune.enable = true;
      };
    };
    environment.systemPackages = [
      (mkIf cfg.podman.enable pkgs.podman-compose)
      (mkIf cfg.podman.enable pkgs.docker-compose)
    ];

    environment.variables = mkIf cfg.podman.enable {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };
  };
}
