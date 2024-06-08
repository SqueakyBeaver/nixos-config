{lib, ...}:
# networking configuration
{
  networking = {
    # FIXME: Put your preferred hostname
    hostname = "toaster-oven-of-death";

    # use my nextDNS config
    nameservers = [
      "45.90.28.0#7dbdb5.dns.nextdns.io"
      "2a07:a8c0::#7dbdb5.dns.nextdns.io"
      "45.90.30.0#7dbdb5.dns.nextdns.io"
      "2a07:a8c1::#7dbdb5.dns.nextdns.io"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };

  # Don't wait for network startup
  # systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
