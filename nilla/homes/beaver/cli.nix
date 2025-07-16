{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    miktex

    # programming stuff
    nil
    alejandra
    llvmPackages.clang-unwrapped
  ];

  programs = {
    bottom = {
      enable = true;
      settings = {
        flags = {
          enable_gpu = true;
          temperature_type = "c";
        };
      };
    };
  };

  # sops.age.keyFile = "/home/beaver/.config/sops/age/keys.txt";
}
