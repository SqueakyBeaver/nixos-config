{
  lib,
  pkgs,
  inputs,
  namespace,
  system,
  config,
  ...
}:
with lib; let
  module = "apps";
  appName = "hmm";
  cfg = config.${namespace}.${module}.${appName};
in {
  options.${namespace}.${module}.${appName} = {
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
      inputs.hmm.packages.${system}.default
    ];
  };
}
