{ inputs, pkgs, self, ... }:
{
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
      hyprexpo
    ];

    systemd = {
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
