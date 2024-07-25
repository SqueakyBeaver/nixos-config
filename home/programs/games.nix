{pkgs, ...}: {
  home.packages = with pkgs; [
    protonup-qt
    protontricks
    prismlauncher
    gamescope
    mangohud
  ];

  home.sessionVariables = {
    MANGOHUD = 1;
  };
}
