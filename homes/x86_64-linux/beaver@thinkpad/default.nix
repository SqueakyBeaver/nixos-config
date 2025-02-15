{config, ...}: {
  imports = [
    ./syncthing
  ];

  timber = {
    browser.enable = true;
    editors = {
      enable = true;
      android.enable = true;
    };
    terminal.enable = true;

    apps = {
      bitwarden.enable = true;
      bottles.enable = true;
      graphics.enable = false;
      obsidian.enable = false;
      prismlauncher.enable = true;
      spotify.enable = true;
      discord.enable = true;
      vlc.enable = true;
      libreoffice.enable = true;
      pixelflasher.enable = true;
      dolphin.enable = true;
      musescore = {
        enable = true;
        sounds.enable = true;
      };
    };
  };

  sops.age.keyFile = "/home/beaver/.config/sops/age/keys.txt";
}
