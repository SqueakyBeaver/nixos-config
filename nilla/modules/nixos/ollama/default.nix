# I don't like genai, but if I'm going to use it, it's going to be local
{
  config,
  lib,
  ...
}: let
  module = "ollama";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable the use of ollama
      '';
    };

    accel = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
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

  config = lib.mkIf cfg.enable {
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
