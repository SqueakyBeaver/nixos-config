{
  pkgs,
  self,
  ...
}: {
  imports = [
    ./fonts.nix
    ./games.nix
    ./home-manager.nix
    ./kde.nix
    ./xdg.nix
  ];

  programs = {
    firefox.enable = true;
    zsh.enable = true;
    kdeconnect.enable = true;
  };
}
