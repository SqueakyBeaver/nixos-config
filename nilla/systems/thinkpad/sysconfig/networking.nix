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

      # not gonna use my nextdns config here
      # The only time I really need it is when browsing the web,
      # and firefox connects to it via https
      nameservers = [
        "9.9.9.9#dns.quad9.net"
      ];

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi.macAddress = "random";
        ethernet.macAddress = "random";
        # NOTE: If we have issues with LLMNR, this might be the culprit?
        connectionConfig = {
          "ipv4.dhcp-send-hostname" = false;
          "ipv6.dhcp-send-hostname" = false;
          "connection.mdns" = "yes";
        };
      };

      firewall = {
        allowedTCPPorts = [
          5355 # LLMNR
          # 7236 # Miracast
          # 7250 # Miracast
          22000 # Syncthing
        ];

        allowedUDPPorts = [
          5353 # Miracast and mDNS
          5355 # LLMNR
          # 7236 # Miracast
          21027 # Syncthing
          22000 # Syncthing
        ];
      };
    };

    services = {
      # DNS resolver
      resolved = {
        enable = true;
        llmnr = "true";
        domains = ["~."];
        dnsovertls = "opportunistic";
      };

      printing = {
        enable = true;
        openFirewall = true;
        drivers = [
          pkgs.gutenprint
          pkgs.cups-filters
          pkgs.cups-browsed
        ];
        browsing = true;
      };

      samba.enable = true;
      samba.openFirewall = true;

      openssh = {
        enable = true;
        settings.UseDns = true;
      };

      tailscale = {
        enable = true;
        openFirewall = true;
        # Commented since I don't need tailscale to be on all time
        # authKeyFile = config.sops.secrets.tailscale_auth_key.path;
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
        enable = true;
        package = pkgs.wireshark-qt;
      };

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
