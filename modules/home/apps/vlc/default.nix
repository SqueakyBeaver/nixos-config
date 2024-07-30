{
  lib,
  config,
  namespace,
  ...
}:
with lib; let
  module = "apps";
  appName = "vlc";
  cfg = config.${namespace}.${module}.${appName};
in {
  options.${namespace}.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to install VLC
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.vlc
    ];
  };
}
