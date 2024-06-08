{ pkgs, self, ... }:
{
  imports = [
    ./settings.nix
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      # hyprbars
      #hyprexpo
    ];
  };
}
