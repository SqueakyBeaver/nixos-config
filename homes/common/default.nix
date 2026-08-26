{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cli.nix
  ];
  
  xdg = {
    enable = true;
    localBinInPath = true;
  };

  nix.gc = {
    automatic = true;
  };
}
