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
      userEmail = "squeaky.beaver4133@protonmail.com"; # hehe funnee email

      # https://blog.gitbutler.com/how-git-core-devs-configure-git/
      extraConfig = {
        column = {
          ui = "auto";
        };
        branch = {
          sort = "-committerdate";
        };
        tag = {
          sort = "version:refname";
        };
        init = {
          defaultBranch = "main";
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        # Why the hell not?
        help = {
          autocorrect = "prompt";
        };
        commit = {
          verbose = true;
        };
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        core = {
          excludesfile = "~/.gitignore";
          # fsmonitor = true; # Personal taste
          # untrackedCache = true; # Personal taste
        };
        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };
        merge = {
          conflictstyle = "zdiff3"; # Personal taste
        };
        pull = {
          rebase = true; # Personal taste
        };
      };
    };
  };

  # Workaround for bad ~/.ssh/config file permissions
  home.file = {
    ".ssh/config" = {
      target = ".ssh/config_source";
      onChange = ''cat .ssh/config_source > .ssh/config && chmod 400 .ssh/config'';
    };
  };
}
