final: prev: {
  musescore-appimage = prev.callPackage ../packages/musescore-appimage {};

  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    # Not using a pinned version so that way I know I stay up to date (sorry)
    spotx = prev.fetchurl {
      url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/refs/heads/main/spotx.sh";
      hash = "sha256-7YW4yaIgamuKrdKpjPEwFqnCWX+9pGvvVYvwGySR9VA=";
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
  vivaldi =
    (prev.vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [final.kdePackages.wrapQtAppsHook];
    }))
    .override {
      qt5 = final.qt6;
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--ozone-platform-hint=auto"
        "--enable-features=WaylandWindowDecorations"
      ];
      # The following two are just my preference, feel free to leave them out
      proprietaryCodecs = true;
      enableWidevine = true;
    };
}
