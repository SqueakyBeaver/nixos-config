{
  pkgs,
  config,
  lib,
  project,
  ...
}: let
  module = "apps";
  appName = "hmm";
  cfg = config.${module}.${appName};
in {
  options.${module}.${appName} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install hedge mod manager
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      project.inputs.hmm.result.packages.${pkgs.system}.default
    ];
  };
}
