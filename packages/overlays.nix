{inputs, ...}: final: prev: let
in {
  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    # Not using a pinned version so that way I know I stay up to date (sorry)
    spotx = "${inputs.spotx-bash}/spotx.sh";
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

  valent = prev.valent.overrideAttrs (finalAttrs: prevAttrs: {
    src = inputs.valent;
  });

  firedragon =
    prev.firedragon.overrideAttrs (finalAttrs: prevAttrs: {
    });

  # keyd = prev.keyd.overrideAttrs (finalAttrs: prevAttrs: {
  #   src = inputs.keyd;
  # });

  pixelflasher = prev.pixelflasher.overrideAttrs (finalAttrs: prevAttrs: {
    src = inputs.pixelflasher;
    version = "8.13.0.0"; # Probably won't update the version bc idc
  });
}
