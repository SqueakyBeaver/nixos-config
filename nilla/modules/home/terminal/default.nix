{
  config,
  lib,
  ...
}: let
  module = "terminal";
  cfg = config.${module};
in {
  options.${module} = {
    # Not needed in machines with no window system
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to install custom terminal emulators";
    };
    alacritty.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to install alacritty
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = lib.mkIf cfg.alacritty.enable {
      enable = true;

      settings = {
        window = {
          startup_mode = "Windowed";
          padding = {
            x = 20;
            y = 20;
          };
        };

        font = lib.mkDefault {
          normal = {
            family = "Fira Code";
            style = "Regular";
          };
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
          vi_mode_style = {
            shape = "Block";
            blinking = "On";
          };
        };
      };
    };
  };
}
