# Everything needed for the window manager or whatever it's called
{ pkgs, self, ... }:
{
  imports = [
    ./hyprland
    ./dunst
    
    ./hyprlock.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp

    # utils
    self.packages.${pkgs.system}.wl-ocr
    # wl-clipboard
    cliphist
    wl-screenrec
    wlr-randr
  ];
}
