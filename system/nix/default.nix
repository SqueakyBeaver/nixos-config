{ config, pkgs, inputs, lib, ... }: {
  imports = [
    ./nixpkgs.nix
  ];

  # we need git for flakes
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    gcc
  ];

  nix = {
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
