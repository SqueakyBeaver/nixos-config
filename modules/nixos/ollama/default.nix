# I don't like genai, but if I'm going to use it, it's going to be local
{
  lib,
  config,
  ...
}:
with lib; let
  module = "ollama";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Enable the use of ollama
      '';
    };

    accel = mkOption {
      type = types.nullOr (
        types.enum [
          false
          "rocm"
          "cuda"
        ]
      );
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
