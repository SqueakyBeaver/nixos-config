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
        "2620:fe::fe#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
        "2620:fe::9#dns.quad9.net"
        "1.1.1.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
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
        };
      };

      firewall = {
        allowedTCPPorts = [
          5355 # LLMNR
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
      };
    };

    services = {
      # DNS resolver
      resolved = {
        enable = true;
        domains = ["~."];
        dnsovertls = "opportunistic";
        fallbackDns = [
          "9.9.9.9"
          "2620:fe::fe"
          "1.1.1.1"
          "2606:4700:4700::1111"
          "8.8.8.8" # Please never get to here
        ];
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
