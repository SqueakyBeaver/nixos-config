{
  pkgs,
  config,
  project,
  ...
}: {
  environment.systemPackages = [
    # Nilla stuff
    pkgs.npins
    (project.inputs.nilla-cli.result.packages.default.result.${pkgs.system})
    (project.inputs.nilla-nixos.result.packages.default.result.${pkgs.system})
    (project.inputs.nilla-home.result.packages.default.result.${pkgs.system})
  ];
}
