{
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "terminal";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    # Not needed in machines with no window system
    enable = mkEnableOption "Whether to install custom terminal emulators";
    alacritty.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install alacritty
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = mkIf cfg.alacritty.enable {
      enable = true;

      settings = {
        window.startup_mode = "Maximized";

        # font = {
        #   normal = {
        #     family = "Fira Code";
        #     style = "Regular";
        #   };
        # };

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
