{
  config,
  pkgs,
  lib,
  project,
  ...
}: {
  systemd.tmpfiles.rules = [
    "D /tmp 1777 root root 7d"
  ];
}
