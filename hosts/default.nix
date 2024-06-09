{ self, inputs, homeImports, ... }: {
  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;
      mod = "${self}/system";

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      toaster-oven-of-death = nixosSystem {
        inherit specialArgs;
        modules = [
          ./laptop

          "${mod}/programs"
          "${mod}/services"
          {
            home-manager = {
              users.beaver.imports = homeImports."beaver@laptop";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
      };
    };
}
