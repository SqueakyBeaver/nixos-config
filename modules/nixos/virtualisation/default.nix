{
  lib,
  config,
  ...
}:
with lib; let
  module = "virtualisation";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkEnableOption "Whether to enable virtualisation";
    podman.enable = mkEnableOption "Whether to enable Podman";
  };

  config = {
    virtualisation = {
      libvirtd.enable = cfg.enable;
      podman = mkIf cfg.podman.enable {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    programs.virt-manager.enable = cfg.enable;
  };
}
