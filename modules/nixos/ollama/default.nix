# I'm literally using this for like one thing, but oh well
{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "ollama";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Enable the use of ollama";
    acceleration = mkOption {
      type = types.string;
      default = "";
      description = ''
        Acceleration interface to use
      '';
    };
    package = mkPackageOption pkgs "ollama" {};
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.acceleration;
      package = cfg.package;
      openFirewall = true;
    };
  };
}
