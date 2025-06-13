final: prev: {
  musescore-appimage = prev.callPackage ./musescore.nix {};

  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    # Not using a pinned version so that way I know I stay up to date (sorry)
    spotx = prev.fetchurl {
      url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/refs/heads/main/spotx.sh";
      hash = "sha256-/p6cJKzaZzjcLJISFudstQjs+lPXnXx4f0vxKbF9Sqw=";
    };
    installPhase =
      builtins.replaceStrings [
        "runHook postInstall"
      ]
      [
        ''
          bash $spotx -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      prevAttrs.installPhase;

    nativeBuildInputs =
      prevAttrs.nativeBuildInputs
      ++ [
        final.curl
        final.perl
        final.util-linux
        final.unzip
        final.zip
      ];
  });
}
