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
    vaultwarden = 8000;
    overleaf = 6969;
    jellyfin = 8096;
    seerr = 5055;
  };
in {
  imports = [
    ./services/jellyfin.nix
    ./services/overleaf.nix
  ];

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
              service = "http://localhost:${builtins.toString ports.plantuml}";
            };
            "vault.${domain}" = {
              service = "http://localhost:${builtins.toString ports.vaultwarden}";
            };
            "overleaf.${domain}" = {
              service = "http://localhost:${builtins.toString ports.overleaf}";
            };
            "jelly.${domain}" = {
              service = "http://localhost:${builtins.toString ports.jellyfin}";
            };
            "seerr.${domain}" = {
              service = "http://localhost:${builtins.toString ports.seerr}";
            };
          };

          default = "http_status:404";
        };
      };
    };

    caddy = {
      enable = true;
      acmeCA = "https://acme-staging-v02.api.letsencrypt.org/directory";
      virtualHosts = {
        "plantuml.${domain}".extraConfig = ''
          tls internal
          reverse_proxy http://localhost:${builtins.toString ports.plantuml}
        '';
        "vault.${domain}".extraConfig = ''
          tls internal
          reverse_proxy http://localhost:${builtins.toString ports.vaultwarden}
        '';
        "overleaf.${domain}".extraConfig = ''
          tls internal
          reverse_proxy http://localhost:${builtins.toString ports.overleaf}
        '';
        "jelly.${domain}".extraConfig = ''
          tls internal
          reverse_proxy http://localhost:${builtins.toString ports.jellyfin}
        '';
        "seerr.${domain}".extraConfig = ''
          tls internal
          reverse_proxy http://localhost:${builtins.toString ports.seerr}
        '';
      };
    };

    # The actual services
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      # TODO: Use a better dir?
      # backupDir = "/var/backup/vaultwarden";
      environmentFile = config.sops.secrets.vaultwarden.path;
      config = {
        DOMAIN = "https://vault.${domain}";
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
      format = "dotenv";
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
