{ pkgs, self, inputs, lib, ... }:
let
in {
  imports = [
    ./hardware-configuration.nix
  ];

  users.groups.beaver = { };
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky beaver";
    group = "beaver";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };


  networking.hostName = "toaster-oven-of-death";
}
