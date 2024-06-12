{ pkgs, ... }:
let
  pyinstaller = pkgs.callPackage ./pyinstaller;
in
{
  pixelflasher = pkgs.callPackage ./pixelflasher { inherit pyinstaller; };
}
