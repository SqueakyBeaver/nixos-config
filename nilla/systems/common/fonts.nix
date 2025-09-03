{
  pkgs,
  config,
  ...
}: {
  config.fonts = {
    packages = with pkgs; [
      # Sans(Serif) fonts
      noto-fonts
      noto-fonts-emoji
      inter
      inter-nerdfont
      fira-sans

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
        sansSerif = ["Fira Sans" "Noto Sans" "Inter"];
        monospace = ["JetBrains Mono" "Fira Code"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
