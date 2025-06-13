{
  config,
  lib,
  ...
}: let
  module = "syncthing";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable the use of SyncThing on this system
      '';
    };
  };

  config = lib.mkIf cfg.enable {
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
