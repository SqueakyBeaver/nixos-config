{
  channels,
  inputs,
  ...
}: final: prev: {
  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    spotx = prev.fetchurl {
      url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh";
      hash = "sha256-AGTxNbR+jAi7X5DQYyi2UfEYPg71sljO6S4PQH0hypA=   ";
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
