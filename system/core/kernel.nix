{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # https://nixos.wiki/wiki/Linux_kernel
}
