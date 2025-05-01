{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      noto-fonts
      noto-fonts-emoji
      roboto
      inter
      fira-sans
      manrope
      montserrat
      fraunces

      # monospace fonts
      jetbrains-mono
      fira-code
      fira-code-symbols

      # nerdfonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    # causes more issues than it solves
    enableDefaultPackages = true;

    fontDir.enable = true;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig = {
      subpixel.rgba = "rgb";
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Fira Sans" "Manrope" "Montserrat"];
        monospace = ["JetBrains Mono" "Fira Code"];
        emoji = ["Symbols Nerd Font" "Noto Color Emoji" "Material Symbols"];
      };
    };
  };
}
