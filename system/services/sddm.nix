{
  pkgs,
  inputs,
  ...
}: {
  # I don't feel like making another file right now
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    theme = "breeze";
  };
}
