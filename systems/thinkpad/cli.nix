{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.just
    pkgs.rocmPackages.rocm-smi # For btop gpu monitoring (hope)
    pkgs.android-tools
  ];
}
