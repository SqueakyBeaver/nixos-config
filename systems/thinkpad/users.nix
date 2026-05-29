{pkgs, ...}: {
  users.groups.beaver = {};
  users.users.beaver = {
    isNormalUser = true;
    description = "Squeaky Beaver";
    group = "beaver";
    extraGroups = [
      "adbusers"
      "gamemode"
      "keyd"
      "libvirtd"
      "mysql"
      "networkmanager"
      "podman"
      "render"
      "video"
      "wheel"
      "wireshark"
    ];
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
    shell = pkgs.fish;
  };
}
