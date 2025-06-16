let
  pins = import ./npins;

  nilla = import pins.nilla;
in
  nilla.create ({config}: {
    includes = [
      ./nilla

      # TODO: look into nilla-nixos.modules.nixos
      "${pins.nilla-nixos}/modules/nixos.nix"
      "${pins.nilla-home}/modules/nixos.nix"
      "${pins.nilla-home}/modules/home.nix"
    ];

    config = {
      # Inspired by
      # https://github.com/FreshlyBakedCake/PacketMix/blob/36990eb658ab4c6c3efa0aaa606dacf3dec285c1/nilla.nix

      packages = {
        allNixOSSystems = {
          systems = ["x86_64-linux"];

          package = {stdenv}:
            stdenv.mkDerivation {
              name = "all-nixos-systems";

              dontUnpack = true;

              buildPhase =
                ''
                  mkdir -p $out
                ''
                + (builtins.concatStringsSep "\n" (
                  config.lib.attrs.mapToList
                  (name: value: ''ln -s "${value.result.config.system.build.toplevel}" "$out/${name}" '')
                  config.systems.nixos
                ));
            };
        };
        default = config.packages.allNixOSSystems;
      };
    };
  })
