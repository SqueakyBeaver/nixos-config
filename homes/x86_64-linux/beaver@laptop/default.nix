{...}: {
  timber = {
    browser.enable = true;
    editors.enable = true;

    apps = {
      bitwarden.enable = true;
      graphics.enable = true;
      obsidian.enable = true;
      prismlauncher.enable = true;
      spotify.enable = true;
      vesktop.enable = true;
      vlc.enable = true;
      # I don't want to update glibc a lot, so I will comment this out
      # pixelflasher.enable = true;
    };
  };
}
