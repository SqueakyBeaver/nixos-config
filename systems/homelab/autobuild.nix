{
  config,
  pkgs,
  ...
}: {
  # Steps:
  # Setup S3 server thingy
  # Setup nginx?
  # Tunnel stuff through tailscale?
  # idk man

  environment.systemPackages = [
    pkgs.cachix
  ];

  networking.firewall.allowedTCPPorts = [ 80 ];


  # Do last
  systemd.services = {
    build-config = {
      description = "Build nixOS config(s) and put the result in the binary cache";
      startAt = "";
      script = ''

      '';
    };
  };
}
