{
  lib,
  namespace,
  config,
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
    services.printing.enable = true;
    services.printing.openFirewall = cfg.openFirewall;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
    };

    services.resolved.extraConfig = ''
      MulticastDNS=resolve
    '';
  };
}
