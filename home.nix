{ config, pkgs, ... }:

{
    home.username = "beaver";
    home.homeDirectory = "/home/beaver";

    home.packages = with pkgs; [
    
    vscode
    nil
    nixpkgs-fmt

    zip

    ripgrep

    cowsay
    file
    which
    tree

    nix-output-monitor

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
