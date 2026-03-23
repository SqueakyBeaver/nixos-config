{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    inxi
    nettools
    gnumake
    bat
  ];
}
