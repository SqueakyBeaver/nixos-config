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
      "wireshark"
      "podman"
      "video"
      "render"
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
  };
}
