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
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable cloudflared";
    };
  };

  config = lib.mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
    };
  };
}
