{
  self,
  inputs,
  lib,
  homeImports,
  pkgs,
  namespace,
  ...
}: {
  users.groups.beaver = {};
  users.users.beaver = {
    isNormalUser = true;
    description = "The one who builds";
    group = "beaver";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };
}
