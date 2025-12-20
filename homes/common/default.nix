{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cli.nix
    ./stylix.nix
  ];
  nix.gc = {
    automatic = true;
  };
}
