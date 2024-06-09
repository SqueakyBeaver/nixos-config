{ pkgs, self, ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        dpi-aware = "no";
        icon-theme = "breeze";
        width = 25;
        font = "Inter:size=12";
        line-height = 50;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "wezterm";
        prompt = "❯   ";
        layer = "overlay";
      };
      colors = {
        background = "00000080";
        selection = "0000003f";
        border = "fffffffa";
      };
      border = {
        radius = 20;
      };
      dmenu = {
        exit-immediately-if-empty = "yes";
      };
    };
  };
}
