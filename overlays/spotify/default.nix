{
  channels,
  inputs,
  ...
}: final: prev: {
  spotify = prev.spotify.overrideAttrs (finalAttrs: prevAttrs: {
    installPhase =
      builtins.replaceStrings [
        "runHook postInstall"
      ]
      [
        ''
          bash <(curl -sSL https://spotx-official.github.io/run.sh) -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      prevAttrs.installPhase;
  });
}
