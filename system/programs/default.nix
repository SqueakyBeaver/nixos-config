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

  # Temporary; for testing out some server stuff
  virtualisation.virtualbox = {
    host.enable = true;
    host.enableKvm = true;
    # Don't exactly know what this does, but we shall find out
    guest.enable = true;
  };
  users.extraGroups.vboxusers.members = ["beaver"];
}
