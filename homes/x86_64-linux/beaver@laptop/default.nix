{...}: {
  programs.zsh.enable = true;

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
    };
  };
}
