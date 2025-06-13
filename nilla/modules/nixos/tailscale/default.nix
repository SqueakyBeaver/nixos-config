{
  config,
  lib,
  ...
}: let
  module = "networking.tailscale";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Enable the tailscale service
      '';
    };

    exitNode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to make the device an exit node
      '';
    };

    useSSH = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to advertise ssh on this device
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;

      useRoutingFeatures =
        if cfg.exitNode
        then "both"
        else "client";

      extraUpFlags =
        [
          "--accept-routes"
        ]
        ++ lib.mkIf cfg.exitNode [
          "--advertise-exit-node"
        ]
        ++ lib.mkIf cfg.useSSH [
          "--ssh"
        ];
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = "true";
  };
}
