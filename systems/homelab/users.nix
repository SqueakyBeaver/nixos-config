{pkgs, ...}: {
  users.groups.otter = {};
  users.users.otter = {
    isNormalUser = true;
    description = "Playful Otter";
    group = "otter";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "libvirtd"
      "adbusers"
      "mysql"
      "wireshark"
      "podman"
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
    shell = pkgs.zsh;
  };
}
