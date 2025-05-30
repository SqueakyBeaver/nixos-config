{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  module = "browser";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkEnableOption "Whether to install browsers";
    firefox.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to enable firefox
      '';
    };

    chromium.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable ungoogled chromium
      '';
    };

    vivaldi.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable vivaldi
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = mkIf cfg.firefox.enable {
      enable = true;
      nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
    };

    programs.chromium = mkIf cfg.chromium.enable {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };

    programs.vivaldi = mkIf cfg.vivaldi.enable {
      enable = true;
      package = pkgs.vivaldi;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration
      ];
    };
  };
}
