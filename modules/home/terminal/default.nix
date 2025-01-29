{
  config,
  lib,
  ...
}:
with lib; let
  module = "terminal";
  cfg = config.${module};
in {
  options.${module} = {
    # Not needed in machines with no window system
    enable = mkEnableOption "Whether to install terminal emulators";
    wezterm.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to use wezterm
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = mkIf cfg.wezterm.enable {
      enable = true;
    };
  };
}
