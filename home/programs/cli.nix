{ pkgs, ... }: {

  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    p7zip

    # misc
    libnotify

    # utils
    du-dust
    wl-clipboard
    duf
    fd
    file
    jaq
    ripgrep
    just
    which
    tree
    btop
    iotop
    iftop
    thefuck
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;

    git = {
      enable = true;
      # FIXME: If you copy this, change it
      userName = "Beaverr";
      userEmail = "theboxguy659@gmail.com";
    };
  };
}
