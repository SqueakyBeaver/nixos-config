{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pciutils
    pkgs.usbutils
    pkgs.inxi
    pkgs.nettools
    pkgs.gnumake
  ];
}
