{
  config,
  lib,
}: let
  pins = import ../npins;

  nixpkgs-flake = config.inputs.flake-compat.result.load {
    src = config.inputs.nixpkgs.src;
  };

  doNotImport = [
    "spotx-bash"
    "valent"
  ];

  loaders = {
    home-manager = "flake";
    nixpkgs = "nixpkgs";

    # Apparently flakes will always be used before nilla ;-;
    nilla-cli = "nilla";
    nilla-nixos = "nilla";
    nilla-home = "nilla";
  };

  settings = {
    nixpkgs = {
      configuration = {
        allowUnfree = true;
      };
      overlays = [
        (import ./packages/overlays.nix)
        config.inputs.emacs-overlay.result.overlays.default
        config.inputs.lix-module.result.overlays.lixFromNixpkgs
        config.inputs.niri.result.overlays.niri
      ];
    };
    # Flake
    auto-cpufreq = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    disko = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    hmm = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    home-manager = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    lix-module = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    nix-index-db = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    nixvim = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    plasma-manager = {
      inputs.nixpks = nixpkgs-flake;
    };
    sops-nix = {
      inputs.nixpkgs = nixpkgs-flake;
    };
    stylix = {
      inputs.nixpkgs = nixpkgs-flake;
    };
  };
in {
  config = {
    inputs =
      builtins.mapAttrs
      (name: pin: {
        src = pin;

        loader = lib.modules.when (loaders ? ${name}) loaders.${name};
        settings = lib.modules.when (settings ? ${name}) settings.${name};
      })
      (builtins.removeAttrs pins doNotImport);
  };
}
