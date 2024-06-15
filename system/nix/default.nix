{ config, pkgs, inputs, lib, ... }: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = with pkgs; [
    git
    # neovim
    wget
    curl
    gcc
    gnome.nautilus
    gtksourceview # hope
    # inputs.nixvim.packages."x86_64-linux".default
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [ "root" "wheel" ];
    };
  };
}
