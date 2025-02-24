# I don't like genai, but if I'm going to use it, it's going to be local
{
  lib,
  pkgs,
  inputs,
  namespace,
  config,
  ...
}:
with lib; let
  module = "ollama";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable the use of ollama
      '';
    };

    accel = mkOption {
      type = types.string;
      default = null;
      description = ''
        The gpu acceleration to use. Same as `services.ollama.acceleration`
      '';
    };
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.accel;
      openFirewall = true;
    };

    services.open-webui = {
      enable = true;
      # teehee i'm sooooo funnyyyy
      port = 42069;
      openFirewall = true;
    };
  };
}
