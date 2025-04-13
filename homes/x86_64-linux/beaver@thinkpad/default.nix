{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./syncthing
    # ./niri.nix
  ];

  timber = {
    browser = {
      enable = true;
      vivaldi.enable = true;
    };

    editors = {
      enable = true;
      android.enable = true;
      nvim.enable = true;
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
      pixelflasher.enable = true;
      dolphin.enable = true;
      musescore = {
        enable = true;
        sounds.enable = true;
      };
      hmm.enable = true;
      fluffychat.enable = true;
    };
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
  };
}
