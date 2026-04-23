{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cli.nix
    # ./stylix.nix
  ];
  
  xdg = {
    enable = true;
    localBinInPath = true;
  };

  nix.gc = {
    automatic = true;
  };
}
