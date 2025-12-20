# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT
#
# https://github.com/FreshlyBakedCake/PacketMix/blob/f7945c8f82bc3a08e6eefdf2f3bd4650b1e5033d/systems/common/inputs.nix
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  # https://github.com/orgs/nilla-nix/discussions/12
  nixpkgs.flake = {
    source = builtins.path {
      name = "source";
      inherit (pkgs) path;
    };
    # I don't like fetching nixpkgs every time I use a flake
    setFlakeRegistry = true;
    setNixPath = true;
  };
  nix = {
    channel.enable = false; # disable imperative channels
    nixPath = ["/etc/nixos-inputs"];
  };

  environment.etc =
    lib.mapAttrs' (name: value: {
      name = "nixos-inputs/${name}";
      value.source =
        if
          (lib.strings.isStringLike value.result)
          # We convert to a string here to force paths out of any attrsets/etc.
          && (lib.strings.hasPrefix builtins.storeDir (builtins.toString value.result))
        then builtins.storePath value.result
        else builtins.storePath value.src;
    })
    inputs;
}
