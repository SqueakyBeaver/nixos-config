{
  lib,
inputs,
pkgs,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "hmm";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install hedge mod manager
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.hmm.packages.${pkgs.system}.default
    ];
  };
}
