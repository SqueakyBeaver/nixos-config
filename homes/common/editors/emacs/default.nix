{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.shellcheck
    pkgs.discount
    pkgs.graphviz
    pkgs.gnuplot
    pkgs.sqlite
    pkgs.gnutls
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };

  services.emacs = {
    enable = true;
  };

  # For doom emacs' doom script thingy
  home.sessionPath = [
    "$HOME/.emacs.d/bin"
  ];
}
