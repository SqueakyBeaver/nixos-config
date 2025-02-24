{
  inputs,
  config,
  ...
}: {
  config.home-manager.useGlobalPkgs = true;
  config.home-manager.useUserPackages = true;
}