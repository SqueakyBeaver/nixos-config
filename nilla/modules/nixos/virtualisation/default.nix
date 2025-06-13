{
  lib,
  config,
  pkgs,
  ...
}: let
  module = "virt";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable virtualisation";
    };
    podman.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Podman";
    };
  };

  config = {
    programs.virt-manager.enable = cfg.enable;

    virtualisation = {
      libvirtd.enable = cfg.enable;
      spiceUSBRedirection.enable = cfg.enable;

      podman = lib.mkIf cfg.podman.enable {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
        autoPrune.enable = true;
      };
    };

    environment.systemPackages = [
      (lib.mkIf cfg.podman.enable pkgs.podman-compose)
      (lib.mkIf cfg.podman.enable pkgs.docker-compose)
    ];

    environment.variables = lib.mkIf cfg.podman.enable {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };
  };
}
