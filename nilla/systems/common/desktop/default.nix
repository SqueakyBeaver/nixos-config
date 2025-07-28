{
  config,
  lib,
  ...
}: {
  options = {
    desktop.environment = lib.mkOption {
      type = lib.types.enum ["plasma" "niri" "hyprland"];
      description = "Which WM/Compositor/DE to use (default: Plasma 6)";
      default = "plasma";
    };
  };

  imports = [./hyprland.nix ./kde.nix ./niri.nix];
}
