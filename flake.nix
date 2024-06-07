{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

        nixosConfigurations = {
      toaster-oven-of-death = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./sys/configuration.nix
        ];
      };
    };
};
}
