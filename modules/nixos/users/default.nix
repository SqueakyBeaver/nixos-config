{pkgs, ...}: {
  users.users.beaver = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
  };

  users.users.dam = {
    isNormalUser = true;

    extraGroups = ["wheel"];
  };
}
