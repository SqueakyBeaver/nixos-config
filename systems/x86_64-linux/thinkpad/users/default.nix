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
    description = "Squeaky Beaver";
    group = "beaver";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
      "adbusers"
      "podman"
    ];
    shell = pkgs.zsh;
  };
}
