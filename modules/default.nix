{
  # flake.nixosModules = {
  #   theme = import ./theme;
  # };

  imports = [ ./theme ];
}
