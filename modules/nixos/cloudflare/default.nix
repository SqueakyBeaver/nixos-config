# I'm literally using this for like one thing, but oh well
{
  config,
  lib,
  ...
}:
with lib; let
  module = "cloudflare";
  cfg = config.${module};
in {
  options.${module} = {
    enable = mkEnableOption "enable cloudflared";
    
  };

  config = mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
      
    };
  };
}
