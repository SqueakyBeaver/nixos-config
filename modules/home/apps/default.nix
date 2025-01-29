{lib, ...}: {
  # Import all directories in this directory 
  # TODO: Reorganize this whenever I get things setup and know what I don't need
  imports = builtins.attrNames
    (lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./.));
}
