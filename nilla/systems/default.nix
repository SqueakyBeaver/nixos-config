{config}: {
  includes = [
    ./thinkpad
    # ./homelab
    # ./server
  ];

  config.modules = {
    lix = config.inputs.lix-module.result;
    niri = config.inputs.niri.result;
    stylix = config.inputs.stylix.result;
    home-manager = config.inputs.home-manager.result;
    nixos-hardware = config.inputs.nixos-hardware.result;
    sops-nix = config.inputs.sops-nix.result;
  };
}
