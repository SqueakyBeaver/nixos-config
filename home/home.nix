{ config, pkgs, ... }:
{
  home.username = "beaver";
  home.homeDirectory = "/home/beaver";

  home.packages = with pkgs; [
    # Coding stuff

    # Text editors / IDEs
    vscode # android-studio #commented bc it takes a lot of downloads

    # LSPs, etc
    nil
    nixpkgs-fmt

    # Languages
    go
    python3
    rustc
    cargo
    nodejs

    # Python packages
    python312Packages.pip
    thefuck

    # gaems
    steam
    protonup-qt
    protontricks
    gamemode
    prismlauncher # minecarft

    # random utilities
    gimp
    inkscape
    vesktop
    zsh
    vlc
    just

    # misc
    bitwarden
    zip
    unzip
    ripgrep
    cowsay
    file
    which
    tree

    nix-output-monitor

    # monitors
    btop
    iotop
    iftop

    strace
    ltrace
    lsof

    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];

  programs.git = {
    enable = true;
    userName = "Beaverr";
    userEmail = "theboxguy659@gmail.com";
  };

  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "nixos-rebuild switch --flake /home/beaver/nixos-config#toaster-oven-of-death";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.alacritty = {
    enable = true;
  };

  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
