{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["kde"];
    };

    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };
}
