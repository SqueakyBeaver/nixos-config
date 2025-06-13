{
  lib,
  config,
  ...
}:
with lib; let
  module = "flatpak";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Enable the use of flatpaks
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
