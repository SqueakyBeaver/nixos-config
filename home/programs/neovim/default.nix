{
  imports =  [
    ./completion.nix
    ./keymaps.nix
    ./lsp.nix
    ./settings.nix
  ];
  # Using nixvim
  programs.nixvim = {
    enable = true;
    # defaultEditor = true; # Uncomment when this is finished

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    colorschemes.gruvbox.enable = true;

    globals.mapLeader = " ";

    options = {
      number = true; # Show line numbers
      shiftwidth = 2; # Tab width should be 2
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;

      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
      ];
    };
  };
}
