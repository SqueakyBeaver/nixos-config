{ pkgs, config, ... }: {
  home.pointerCursor = {
    package = pkgs.material-cursors;
    name = "Material Cursors";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };
  
  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 9;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
}
