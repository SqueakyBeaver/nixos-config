{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  # I don't want to set this up per-directory tbh
  module = "latex";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "Whether to install texlive-basic";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.texlive.combined.scheme-basic
      pkgs.texlab
    ];
  };
}
