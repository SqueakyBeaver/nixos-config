{
  programs.helix = {
    enable = true;

    settings = {
      theme = "onedark";

      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "absolute";

        # Dunno how to set this right ._.
        # auto-save.after-delay.enable = true;
        whitespace.render = "all";
        indent-guides.render = true;
        lsp.display-inlay-hints = true;
      };
    };
  };
}
