{ pkgs, self, ... }:
{
  imports = [
    ./core
    ./network
    ./programs
    ./services
  ];

  # idk where else I would put this tbh
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky beaver";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };
}
