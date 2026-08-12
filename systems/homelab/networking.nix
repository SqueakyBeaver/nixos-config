{
  config,
  lib,
  ...
}: {
  networking = {
    nftables.enable = true;
    networkmanager = {
      enable = true;
      # dns = "systemd-resolved";
      # wifi.macAddress = "stable-ssid";
      # ethernet.macAddress = "stable-ssid";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        # 5355 # LLMNR
      ];

      allowedUDPPorts = [
        80
        443
        # 5355 # LLMNR
      ];
    };
  };

  services = {
    # DNS resolver
    # resolved = {
    #   enable = true;
    #   settings = {
    #     Resolve = {
    #       LLMNR = "true";
    #       # Domains = ["~."];
    #       DNSOverTLS = "opportunistic";
    #       # dnssec = "true";
    #     };
    #   };
    # };

    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   # nssmdns6 = true;
    #   openFirewall = true;
    # };

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
}
