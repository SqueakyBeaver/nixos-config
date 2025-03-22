{
  channels,
  inputs,
  ...
}: final: prev: {
  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    # Not using a pinned version so that way I know I stay up to date (sorry)
    spotx = prev.fetchurl {
      url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh";
      hash = "sha256-k4MA3WFLWUX41O/CjYWVxzEK/r+LoS3BxrLuROWzndg=";
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
