{
  self,
  inputs,
  lib,
  pkgs,
  ...
}: {
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
