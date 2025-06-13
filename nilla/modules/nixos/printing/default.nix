{
  config,
  pkgs,
  lib,
  ...
}: let
  module = "printing";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable printing";
    };
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to open the firewall to look for printers
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      openFirewall = cfg.openFirewall;
      drivers = [pkgs.gutenprint];
      browsing = true;
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # services.resolved.extraConfig = ''
    #   MulticastDNS=resolve
    # '';
  };
}
