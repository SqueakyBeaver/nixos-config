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
  users.users.dam = {
    isNormalUser = true;
    description = "The dam; stop the flow";
    group = "beaver";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
      "mysql"
    ];
    shell = pkgs.zsh;
  };
}
