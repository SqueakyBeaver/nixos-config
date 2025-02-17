{
  lib,
  namespace,
  config,
  pkgs,
  ...
}:
with lib; let
  module = "printing";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Whether to enable printing";
    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to open the firewall to look for printers
      '';
    };
  };

  config = mkIf cfg.enable {
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
