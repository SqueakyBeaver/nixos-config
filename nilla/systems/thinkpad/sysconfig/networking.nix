{
  config,
  pkgs,
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

      # useDHCP = false;
      # dhcpcd.enable = false;

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi.macAddress = "random";
      };

      firewall = {
        allowedTCPPorts = [
          1701 # Weylus
          5355 # LLMNR
          9001 # Weylus
          9090
          8080
          7236 # Miracast
          7250 # Miracast
          22000 # Syncthing
        ];

        allowedUDPPorts = [
          5353 # Miracast
          5355 # LLMNR
          7236 # Miracast
          21027 # Syncthing
          22000 # Syncthing
        ];

        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          } # KDE Connect
        ];

        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
          {
            from = 8080;
            to = 8090;
          }
          {
            from = 1714;
            to = 1764;
          } # KDE Connect
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
      printing = {
        enable = true;
        openFirewall = true;
        drivers = [pkgs.gutenprint];
        browsing = true;
      };

      openssh = {
        enable = true;
        settings.UseDns = true;
      };

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
      sopsFile = ./secrets/tailscale.sops.thinkpad.yaml;
    };

    systemd.services.tailscaled.environment.TS_NO_LOGS_NO_SUPPORT = "true";

    programs = {
      wireshark = {
        enable = false;
        package = pkgs.wireshark-qt;
      };

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
