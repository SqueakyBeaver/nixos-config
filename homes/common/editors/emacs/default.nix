{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.doom-emacs.homeModule
  ];

  home.packages = [
    pkgs.shellcheck
    pkgs.discount
    pkgs.graphviz
    pkgs.gnuplot
    pkgs.sqlite
    pkgs.gnutls
    pkgs.clang-tools
    pkgs.dockfmt
    pkgs.sbcl
    pkgs.libxml2
    pkgs.gore
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.nixfmt
    pkgs.nil
  ];

  programs.doom-emacs = {
    enable = true;
    doomDir = ./doomdir;
    doomLocalDir = "/home/beaver/.config/doom/.local";
    experimentalFetchTree = true;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.vterm
      epkgs.nixfmt
      pkgs.nixfmt
      pkgs.emacs-lsp-booster
    ];
  };

  # For doom emacs' doom script thingy
  home.sessionPath = [
    "$HOME/.emacs.d/bin"
  ];
}
