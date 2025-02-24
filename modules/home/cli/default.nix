{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    p7zip

    # misc
    libnotify

    # utils
    duf
    fd
    file
    jaq
    ripgrep
    just
    which
    tree
    btop-rocm
    iotop
    iftop
    thefuck
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
    zsh.enable = true;

    git = {
      enable = true;
      # FIXME: If you copy this, change it
      userName = "Beaverr";
      userEmail = "beaver@transgender.army"; # hehe funnee email
    };
  };

  
  home.file = {
    ".ssh/config" = {
      target = ".ssh/config_source";
      onChange = ''cat .ssh/config_source > .ssh/config && chmod 400 .ssh/config'';
    };
  };
}
