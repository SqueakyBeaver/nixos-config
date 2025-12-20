{config}: {
  config.packages.firedragon-beta-bin = {
    systems = ["x86_64-linux"];
    package = {
      lib,
      stdenv,
      fetchurl,
      config,
      wrapGAppsHook3,
      autoPatchelfHook,
      alsa-lib,
      curl,
      dbus-glib,
      gtk3,
      libXtst,
      libva,
      pciutils,
      pipewire,
      adwaita-icon-theme,
      generated,
      writeScript,
      writeText,
      xidel,
      coreutils,
      gnused,
      gnugrep,
      gnupg,
      runtimeShell,
      systemLocale ? config.i18n.defaultLocale or "en_US",
      patchelfUnstable, # have to use patchelfUnstable to support --no-clobber-old-sections
      applicationName ? "Firedragon Beta",
      undmg,
    }: let
      inherit (generated) version sources;

      binaryName = "firedragon";

      mozillaPlatforms = {
        i686-linux = "linux-i686";
        x86_64-linux = "linux-x86_64";
        aarch64-linux = "linux-aarch64";
        # bundles are universal and can be re-used for both darwin architectures
        aarch64-darwin = "mac";
        x86_64-darwin = "mac";
      };

      arch = mozillaPlatforms.${stdenv.hostPlatform.system};

      isPrefixOf = prefix: string: builtins.substring 0 (builtins.stringLength prefix) string == prefix;

      sourceMatches = locale: source: (isPrefixOf source.locale locale) && source.arch == arch;

      policies =
        {
          DisableAppUpdate = true;
        }
        // config.firefox.policies or {};

      policiesJson = writeText "firefox-policies.json" (builtins.toJSON {inherit policies;});

      defaultSource = lib.findFirst (sourceMatches "en-US") {} sources;

      mozLocale =
        if systemLocale == "ca_ES@valencia"
        then "ca-valencia"
        else lib.replaceStrings ["_"] ["-"] systemLocale;

      source = lib.findFirst (sourceMatches mozLocale) defaultSource sources;

      pname = "firedragon-bin-unwrapped";
    in
      stdenv.mkDerivation {
        inherit pname version;

        src = fetchurl {inherit (source) url sha256;};

        sourceRoot = lib.optional stdenv.hostPlatform.isDarwin ".";

        nativeBuildInputs =
          [
            wrapGAppsHook3
          ]
          ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
            autoPatchelfHook
            patchelfUnstable
          ]
          ++ lib.optionals stdenv.hostPlatform.isDarwin [
            undmg
          ];
        buildInputs = lib.optionals (!stdenv.hostPlatform.isDarwin) [
          gtk3
          adwaita-icon-theme
          alsa-lib
          dbus-glib
          libXtst
        ];
        runtimeDependencies =
          [
            curl
            pciutils
          ]
          ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
            libva.out
          ];
        appendRunpaths = lib.optionals (!stdenv.hostPlatform.isDarwin) [
          "${pipewire}/lib"
        ];
        # Firefox uses "relrhack" to manually process relocations from a fixed offset
        patchelfFlags = ["--no-clobber-old-sections"];

        installPhase =
          if stdenv.hostPlatform.isDarwin
          then ''
            mkdir -p $out/Applications
            mv Firefox*.app "$out/Applications/${applicationName}.app"
          ''
          else ''
            mkdir -p "$prefix/lib/firedragon-bin-${version}"
            cp -r * "$prefix/lib/firedragon-bin-${version}"

            mkdir -p "$out/bin"
            ln -s "$prefix/lib/firedragon-bin-${version}/firedragon" "$out/bin/${binaryName}"

            # See: https://github.com/mozilla/policy-templates/blob/master/README.md
            mkdir -p "$out/lib/firedragon-bin-${version}/distribution";
            ln -s ${policiesJson} "$out/lib/firedragon-bin-${version}/distribution/policies.json";
          '';

        passthru = {
          inherit applicationName binaryName;
          libName = "firedragon-bin-${version}";
          ffmpegSupport = true;
          gssSupport = true;
          gtk3 = gtk3;
        };

        meta = with lib; {
          changelog = "https://gitlab.com/garuda-linux/firedragon/firedragon12/-/releases/${version}";
          description = "Garuda Firedragon 12, free web browser (binary package)";
          homepage = "https://gitlab.com/garuda-linux/firedragon/firedragon12";
          license = licenses.mpl20;
          sourceProvenance = with sourceTypes; [binaryNativeCode];
          platforms = builtins.attrNames mozillaPlatforms;
          hydraPlatforms = [];
          mainProgram = binaryName;
        };
      };
  };
}
