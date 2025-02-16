{
  lib,
  pkgs,
  inputs,
  namespace,
  systems,
  config,
  ...
}:
with lib; let
  module = "syncthing";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the use of SyncThing on this system
      '';
    };
  };

  config = mkIf cfg.enable {
    # enable = true;
    # openDefaultPorts = true;
    # Not gonna enable it bc I think the system syncthing overrides the home-manager config
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [21027 22000];
    };

    # The rest of the settings will be set in the home configs
  };
}
