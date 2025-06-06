{
  inputs,
  pkgs,
  ...
}: {
  imports = with inputs; [
    ./syncthing
    ./niri
    ../../modules/home
    sops-nix.homeManagerModules.sops
    nixvim.homeManagerModules.nixvim
    nix-index-db.hmModules.nix-index
  ];

  browser = {
    enable = true;
    vivaldi.enable = true;
  };

  editors = {
    enable = true;
    android.enable = true;
    nvim.enable = true;
    unity.enable = true;
  };

  terminal.enable = true;

  latex.enable = true;

  apps = {
    bitwarden.enable = true;
    bottles.enable = true;
    graphics.enable = false;
    obsidian.enable = true;
    prismlauncher.enable = true;
    spotify.enable = true;
    discord.enable = true;
    vlc.enable = true;
    libreoffice.enable = true;
    pixelflasher.enable = false;
    dolphin.enable = false;
    musescore = {
      enable = true;
      sounds.enable = true;
    };
    hmm.enable = true;
    fluffychat.enable = true;
    obs.enable = true;
  };

  home.packages = [
    # Should not be enabled for every user, and I don't wanna make a module option
    pkgs.llvmPackages.clang-unwrapped
  ];

  # I do not want to make a whole module option for this atm, but it should not be a default probably
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "confirm";

  sops.age.keyFile = "/home/beaver/.config/sops/age/keys.txt";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ### OOOOH Java font anti-aliasing
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    # For neovim-remote
    # NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
  };

  home.username = "beaver";
  home.homeDirectory = "/home/beaver";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
