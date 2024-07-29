{
  self,
  inputs,
  homeImports,
  pkgs,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    oven-of-death = nixosSystem {
      inherit specialArgs;
      modules = [
        "${mod}/programs"
        "${mod}/services"
        {
          home-manager = {
            users.beaver.imports = homeImports."beaver@server";
            extraSpecialArgs = specialArgs;
          };
        }

        "${mod}"
      ];
    };
  };
}
