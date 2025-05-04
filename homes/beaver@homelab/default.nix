{
  inputs,
  pkgs,
  ...
}: {
  imports = with inputs; [
    ../../modules/home
    nixvim.homeManagerModules.nixvim
    nix-index-db.hmModules.nix-index
  ];

  browser = {
    enable = true;
  };

  editors = {
    enable = true;
    nvim.enable = true;
  };

  terminal.enable = true;


  apps = {
    bitwarden.enable = true;
    vlc.enable = true;
  };

  home.packages = [
    # Should not be enabled for every user, and I don't wanna make a module option
    pkgs.llvmPackages.clang-unwrapped
  ];

  # I do not want to make a whole module option for this atm, but it should not be a default probably
  services.ssh-agent.enable = true;
  programs.ssh.addKeysToAgent = "confirm";


  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ### OOOOH Java font anti-aliasing
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    # For neovim-remote
    NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
  };

  home.username = "beaver";
  home.homeDirectory = "/home/beaver";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
