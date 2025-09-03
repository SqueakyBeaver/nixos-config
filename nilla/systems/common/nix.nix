{
  pkgs,
  config,
  project,
  ...
}: {
  config = {
    # we need git for flakes
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      gcc
      cmake
      (project.inputs.npins.result {})
    ];

    programs.nix-ld = {
      enable = true;
      # Add as we need them
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
      ];
    };

    # Taken from
    # https://github.com/FreshlyBakedCake/PacketMix/blob/main/systems/common/packetmix.nix
    # system.autoUpgrade = {
    #   enable = false;
    #   operation = "boot";
    #   flags = [
    #     "-f"
    #     "/etc/nixos/nilla.nix"
    #     "-A"
    #     "systems.nixos.${config.networking.hostName}.result"
    #   ];
    #   dates = "weekly";
    #   persistent = true;
    # };
    #
    # systemd.services.nixos-upgrade.preStart = ''
    #   ${pkgs.networkmanager}/bin/nm-online -s -q # wait until the internet is online, as esp. if we go offline we need to wait to retry...
    #   cd /etc/nixos
    #   ${pkgs.git}/bin/git fetch
    #   ${pkgs.git}/bin/git checkout origin/main
    # '';
    #
    # systemd.services.nixos-upgrade.serviceConfig = {
    #   Restart = "on-failure";
    #   RestartSec = 5;
    #   RestartSteps = 5;
    #   RestartMaxDelaySec = 86400;
    # };

    nix = {
      package = pkgs.lixPackageSets.latest.lix;
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
  };
}
