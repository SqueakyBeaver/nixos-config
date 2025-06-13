{
  pkgs,
  config,
  ...
}: {
  config.nix.package = pkgs.lix;
}
