final: prev: {
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
