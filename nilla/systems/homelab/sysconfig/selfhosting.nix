{
  config,
  pkgs,
  lib,
  ...
}: let
  domain = "801687692.xyz";
  # Here so I can easily see what ports go where
  ports = {
    plantuml = 62300;
    vaultwarden = config.services.vaultwarden.config.ROCKET_PORT; # 8222 by default
    overleaf = -1;
  };
in {
  services = {
    # I don't wanna forward ports tbh
    cloudflared = {
      enable = true;
      certificateFile = "${config.sops.secrets.cloudflare-cert.path}";
      tunnels = {
        "selfhosting" = {
          credentialsFile = "${config.sops.secrets.cloudflare-creds.path}";

          ingress = {
            "plantuml.${domain}" = {
              service = "http://localhost:${ports.plantuml}";
            };
            "vault.${domain}" = {
              service = "http://localhost:${ports.vaultwarden}";
            };
          };

          default = "http_status:404";
        };
      };
    };

    caddy = {
      enable = true;
      virtualHosts = {
        "plantuml.${domain}".extraConfig = ''
          reverse_proxy 127.0.0.${builtins.toString ports.plantuml}
        '';
        "vault.${domain}".extraConfig = ''
          reverse_proxy 127.0.0.1:${builtins.toString ports.vaultwarden}
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
        DOMAIN = "vault.${domain}";
        SIGNUPS_ALLOWED = false;
      };
    };

    plantuml-server = {
      enable = true;
      listenPort = ports.plantuml;
    };
  };

  sops.secrets = {
    vaultwarden = {
      format = "json";
      sopsFile = ./secrets/vaultwarden.sops.homelab.env;
    };
    cloudflare-cert = {
      format = "binary";
      sopsFile = ./secrets/cloudflared-cert.sops.homelab.pem.bin;
    };
    cloudflare-creds = {
      format = "binary";
      sopsFile = ./secrets/cloudflared-creds.sops.homelab.json.bin;
    };
  };
}
