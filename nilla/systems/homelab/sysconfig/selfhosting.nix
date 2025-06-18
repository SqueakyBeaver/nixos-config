{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    caddy = {
      enable = true;
      virtualHosts = {
        "plantuml.${config.networking.hostName}.corgi-decibel.ts.net".extraConfig = ''
          reverse_proxy 127.0.0.1:62300
        '';
        "vault.${config.networking.hostName}.corgi-decibel.ts.net".extraConfig = ''
          reverse_proxy 127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}
        '';
      };
    };

    # The actual services
    vaultwarden = {
      enable = true;
      dbBackend = "mysql";
      # TODO: Use a better dir?
      backupDir = "/var/backup/vaultwarden";
      environmentFile = config.sops.secrets.vaultwarden.path;
      config = {
        DOMAIN = "vault.${config.networking.hostName}.corgi-decibel.ts.net";
        SIGNUPS_ALLOWED = false;
      };
    };

    plantuml-server = {
      enable = true;
      listenPort = 62300;
    };
  };

  sops.secrets = {
    vaultwarden = {
      format = "json";
      sopsFile = ./secrets/vaultwarden.sops.homelab.env;
    };
  };
}
