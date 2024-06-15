{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./completion.nix
    ./keymaps.nix
    ./lsp.nix
    ./plugins.nix
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

    opts = {
      number = true; # Show line numbers
      shiftwidth = 2; # Tab width should be 2
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;

      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
      ];
    };
  };
}
