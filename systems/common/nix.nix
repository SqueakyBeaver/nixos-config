{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # we need git for flakes
  environment = {
    systemPackages = with pkgs; [
      git
      wget
      curl
      gcc
      cmake
    ];
  };

  programs.nix-ld = {
    enable = true;
    # Add as we need them
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs
    ];
  };

  nix = {
    gc = {
      automatic = true;
      persistent = true;
    };
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];

      trusted-users = ["root" "@wheel"];

      substituters = [
        "https://cache.nixos.org"

        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = lib.mkDefault true;
    };
  };

  system.stateVersion = "24.05";
}
