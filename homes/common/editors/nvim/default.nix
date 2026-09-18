{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./lsp.nix
    ./maps.nix
    ./plugins.nix
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.wl-clipboard
    pkgs.neovim-remote
  ];

  programs = {
    nixvim = {
      enable = true;
      # Not good to enable this, but I hate compiling nil
      nixpkgs.useGlobalPackages = true;

      clipboard.providers.wl-copy.enable = true;
      clipboard.register = "unnamedplus";
      luaLoader.enable = true; # Why not
      performance.byteCompileLua = {
        enable = true;
        plugins = true;
        nvimRuntime = true;
        luaLib = true;
      };

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      opts = {
        nu = true;
        shiftwidth = 0;
        tabstop = 4;
        expandtab = true;
        splitbelow = true;
        cc = "80";
        wrap = false;
        foldlevel = 99;
        foldlevelstart = 99;
        foldenable = true;
      };

      colorschemes = {
        kanagawa = {
          enable = true;
        };
      };
    };
  };
}
