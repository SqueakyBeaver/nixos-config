{
  inputs,
  config,
  ...
}: {
  config.home-manager.useGlobalPkgs = true;
  config.home-manager.useUserPackages = true;
  config.home-manager.backupFileExtension = ".bak";
}
