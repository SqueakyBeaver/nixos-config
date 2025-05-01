{
  lib,
  config,
  ...
}:
with lib; let
  module = "networking.tailscale";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable the tailscale service
      '';
    };

    exitNode = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to make the device an exit node
      '';
    };

    useSSH = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to advertise ssh on this device
      '';
    };
  };

  config = mkIf cfg.enable {
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
        ++ mkIf cfg.exitNode [
          "--advertise-exit-node"
        ]
        ++ mkIf cfg.useSSH [
          "--ssh"
        ];
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = "true";
  };
}
