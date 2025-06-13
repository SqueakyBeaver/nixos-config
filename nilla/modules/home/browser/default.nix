{
  pkgs,
  config,
  lib,
  ...
}: let
  module = "browser";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install browsers";
    };
    firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable firefox
      '';
    };

    chromium.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable ungoogled chromium
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = lib.mkIf cfg.firefox.enable {
      enable = true;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
        pkgs.valent
        pkgs.gnomeExtensions.gsconnect
      ];
    };

    programs.chromium = lib.mkIf cfg.chromium.enable {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
