{config, pkgs, lib, project, ...}: {
  systemd.tmpfiles.rules = [
      "D /tmp 1777 root root 7d"
    ];
  systemd.user.tmpfiles.rules = [
    "D %C - - - 7d"
  ];
}
