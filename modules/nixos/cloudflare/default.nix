# I'm literally using this for like one thing, but oh well
{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
with lib; let
  module = "cloudflare";
  cfg = config.${namespace}.${module};
in {
  options.${namespace}.${module} = {
    enable = mkEnableOption "enable cloudflared";
    
  };

  config = mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
      
    };
  };
}
