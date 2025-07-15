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

      firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
          5355 # LLMNR
        ];

        allowedUDPPorts = [
          80
          443
          5355 # LLMNR
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

      fail2ban = {
        enable = true;
      };

      # TODO: Selfhost headscale?
      tailscale = {
        enable = true;
        openFirewall = true;
        authKeyFile = config.sops.secrets.tailscale_auth_key.path;
        useRoutingFeatures = "client";
        extraUpFlags = [
          # "--accept-routes"
          "--ssh"
        ];
      };
    };

    sops.secrets.tailscale_auth_key = {
      format = "yaml";
      sopsFile = ./secrets/tailscale.sops.homelab.yaml;
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
