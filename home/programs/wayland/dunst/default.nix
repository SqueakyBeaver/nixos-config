{ pkgs, self, ... }:
{
  home.packages = with pkgs; [
    dunst
  ];

  services.dunst = {
    enable = true;
    # Will add when I actually see it
    settings = {
      global = { };
    };
  };
}
