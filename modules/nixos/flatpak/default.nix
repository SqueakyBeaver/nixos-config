{
  lib,
  inputs,
  config,
  ...
}:
with lib; let
  module = "flatpak";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable the use of flatpaks
      '';
    };
  };

  config =
    mkIf cfg.enable {
      services.flatpak.enable = true;
      
    };
}
