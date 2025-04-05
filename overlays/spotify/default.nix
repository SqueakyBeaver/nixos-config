{
  channels,
  inputs,
  ...
}: final: prev: {
  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    # Not using a pinned version so that way I know I stay up to date (sorry)
    spotx = prev.fetchurl {
      url = "https://github.com/SpotX-Official/SpotX-Bash/blob/2a9a5df99ab8fb5d52d371242d8f4e2744973917/spotx.sh";
      hash = "sha256-8XBniIq95FVQ4dh4cT99iAL8irQYmPP0/h4OESM2kvA=";
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
