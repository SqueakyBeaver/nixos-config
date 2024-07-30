{lib, ...}:
# networking configuration
{
  networking = {
    nftables.enable = true;

    # use my nextDNS config
    nameservers = [
      "45.90.28.0" #7dbdb5.dns.nextdns.io"
      # "2a07:a8c0::#7dbdb5.dns.nextdns.io"
      "45.90.30.0" #7dbdb5.dns.nextdns.io"
      # "2a07:a8c1::#7dbdb5.dns.nextdns.io"
      "1.1.1.1"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };

    firewall = {
      allowedTCPPorts = [
        1701 # Weylus
        9001 # Weylus
        9090
        8080
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
      dnsovertls = "opportunistic";
    };
  };
}
