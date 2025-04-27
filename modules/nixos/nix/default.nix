{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # we need git for flakes
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    gcc
    cmake
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "Mon,Wed,Fri *-*-* 09:45";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];

      trusted-users = ["root" "wheel"];

      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"

        "https://nix-community.cachix.org"
        "https://niri.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
  };

  system.stateVersion = "24.05";
}
