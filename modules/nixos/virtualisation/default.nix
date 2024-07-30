{
  lib,
  namespace,
  config,
  ...
}:
with lib; let
  module = "virtualisation";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Whether to enable virtualisation";
    guest.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to enable the guest additions
      '';
    };
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox = {
      host.enable = true;
      host.enableKvm = true;
      # Don't exactly know what this does, but we shall find out
      guest.enable = cfg.guest.enable;
    };
    users.extraGroups.vboxusers.members = ["beaver"];
  };
}
