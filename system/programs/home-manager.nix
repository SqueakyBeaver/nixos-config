{ self, inputs, ... }: {
  imports = [
    inputs.hm.nixosModules.default
  ];

  home-manager = {
    # FIXME: Change the username
    users.beaver.imports = import ../../home;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
  };
}
