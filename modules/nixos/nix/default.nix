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
      experimental-features = ["nix-command" "flakes"];

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "wheel"];

      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"

        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  system.stateVersion = "24.05";
}
