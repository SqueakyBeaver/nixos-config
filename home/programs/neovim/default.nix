{
  config,
  pkgs,
  ...
}: {
  neovim.enable = true;

  xdg.configFile = {
    astronvim = {
      # onChange = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'";
      onChange = "nvim --headless -c 'if exists(\":LuaCacheClear\") | :LuaCacheClear' +quitall";
      source = ./astronvim;
    };
  };
}
