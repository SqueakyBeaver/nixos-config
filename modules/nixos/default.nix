{lib, ...} :
let
  subdirs = lib.filterAttrs (name: val: val == "directory") (builtins.readDir ./.);
  modules = lib.mapAttrsToList (name: val: ./${name}) subdirs;
in
{
  imports = modules;
}

