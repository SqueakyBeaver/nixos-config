{
  config,
  pkgs,
  lib,
  ...
}: let
  # I don't want to set this up per-directory tbh
  module = "latex";
  cfg = config.${module};
in {
  options.${module} = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install texlive-basic";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.texlive.combine {
        inherit
          (pkgs.texlive)
          scheme-medium
          sidecap
          ;
      })
      pkgs.texlab
    ];
  };
}
