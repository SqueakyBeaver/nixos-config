{
  config,
  lib,
  ...
}:
# networking configuration
{
  config = {
    networking = {
      nftables.enable = true;

      # use my nextDNS config
      nameservers = [
        "45.90.28.0#7dbdb5.dns.nextdns.io"
        "2a07:a8c0::#7dbdb5.dns.nextdns.io"
        "45.90.30.0#7dbdb5.dns.nextdns.io"
        "2a07:a8c1::#7dbdb5.dns.nextdns.io"
        # "1.1.1.1"
      ];

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi.macAddress = "random";
      };

      firewall = lib.mkForce {
        enable = true;
        allowedTCPPorts = [
          80
          443
        ];

        allowedUDPPorts = [
          80
          443
        ];
      };
    };

    services = {
      # DNS resolver
      resolved = {
        enable = true;
        domains = ["~."];
        dnsovertls = "opportunistic";
        # dnssec = "true";
      };

      openssh = {
        enable = true;
        settings = {
          UseDns = true;
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      caddy = {
        enable = true;
        virtualHosts."vault.${config.networking.hostName}.corgi-decibel".extraConfig = ''
          reverse_proxy 127.0.0.1:
        '';
        virtualHosts."plantuml.${config.networking.hostName}.corgi-decibel".extraConfig = ''
          reverse_proxy 127.0.0.1:62300
        '';
      };

      fail2ban = {
        enable = true;
        
      };

      tailscale = {
        enable = true;
        permitCertUid = "caddy";
        authKeyFile = config.sops.secrets.tailscale_key.path;
        useRoutingFeatures = "client";
        extraUpFlags = [
          # "--accept-routes"
          "--ssh"
        ];
      };
    };

    sops.secrets.tailscale_key = {
      format = "json";
      sopsFile = ../../thinkpad/sysconfig/tailscale.auth.thinkpad.sops.beaver.json;
      key = "tailscale_auth_key";
    };


    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = "true";

    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
