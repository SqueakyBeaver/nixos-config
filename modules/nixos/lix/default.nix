{
  inputs,
  system,
  pkgs,
  ...
}: {
  # nix.package = inputs.lix-module.packages.${system}.default;
  nix.package = pkgs.lix;
}
