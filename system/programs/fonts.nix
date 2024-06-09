{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      noto-fonts
      noto-fonts-emoji
      roboto
      (google-fonts.override { fonts = [ "Inter" ]; })

      # monospace fonts
      jetbrains-mono
      fira-code
      fira-code-symbols

      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    fontDir.enable = true;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig = {
      subpixel.rgba = "rgb";
      defaultFonts =
        /*let
          addAll = builtins.mapAttrs (k: v: [ "Symbols Nerd Font" ] ++ v ++ [ "Noto Color Emoji" ]);
        in
        addAll*/ {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Inter" "Noto Serif" ];
          monospace = [ "JetBrains Mono" "Fira Code" ];
          emoji = [ "Noto Color Emoji" ];
        };
    };
  };
}
