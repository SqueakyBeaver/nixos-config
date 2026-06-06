{inputs, ...}: final: prev: {
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
    version = "8.14.3.1"; # Probably won't update the version bc idc
  });

  apktool = prev.apktool.overrideAttrs (finalAttrs: prevAttrs: {
    version = "3.0.2";
    src = prev.fetchurl {
      urls = [
        "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_${finalAttrs.version}.jar"
        "https://github.com/iBotPeaches/Apktool/releases/download/v${finalAttrs.version}/apktool_${finalAttrs.version}.jar"
      ];
      hash = "sha256-7uRmmnBKFOBiNAfmcBsLkYh+YeHkBJy3qCgz4Urotf0=";
    };
  });
}
