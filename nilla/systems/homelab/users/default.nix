{pkgs, ...}: {
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
      "mysql"
    ];
    shell = pkgs.zsh;
  };
}
