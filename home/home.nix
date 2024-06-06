{ config, pkgs, ... }:

{
  home.username = "beaver";
  home.homeDirectory = "/home/beaver";

  home.packages = with pkgs; [
    # Coding stuff
    vscode
    # android-studio #commented bc it takes a lot of downloads
    nil
    nixpkgs-fmt
    # go 
    # python 
    # rustc
    # cargo

    # gaems (uncomment section later)
    # steam 
    # protonup-qt
    # protontricks
    # gamemode
    # prismlauncher # minecarft

    # random utilities
    # gimp
    # inkscape
    # vesktop
    zsh
    # spotify
    # vlc


    # misc
    # bitwarden
    zip
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
