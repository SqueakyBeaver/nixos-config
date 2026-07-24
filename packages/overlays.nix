{inputs, ...}: final: prev: {
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

  # I have been waiting for this fix to be merged and put into the unstable channel or whatever
  # I'm done waiting fuck this shit
  python314Packages = prev.python314Packages.overrideScope (
    pyFinal: pyPrev: {
      patool = pyPrev.patool.override {
        file = prev.file.overrideAttrs {
          # Work around too strict landlock hardening
          # https://bugs.astron.com/view.php?id=785
          postPatch = ''
            substituteInPlace src/landlock.c --replace-fail \
              "LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR" \
              "LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_EXECUTE"
          '';
        };
      };
    }
  );

  # I have no idea why but overrideAttrs isn't working and it's too late to figure out why
  nil = prev.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "nil";
    version = "2026-07-23";

    src = prev.fetchFromGitHub {
      owner = "oxalica";
      repo = "nil";
      rev = finalAttrs.version;
      hash = "sha256-upJVI2pq9sOKgF2AILt8l6O4/3GNcMtT/s0rmnbO5UA=";
    };

    cargoHash = "sha256-ZyTrxGX0mRdskxp4o5ssDCyZzNn36rIgP9fDaA1fDws=";

    nativeBuildInputs = [prev.nix];

    env = {
      CFG_RELEASE = finalAttrs.version;
      CFG_DEFAULT_FORMATTER = prev.lib.getExe prev.nixfmt;
    };

    # might be related to https://github.com/NixOS/nix/issues/5884
    preBuild = ''
      export NIX_STATE_DIR=$(mktemp -d)
    '';

    passthru.updateScript = prev.nix-update-script {};

    meta = {
      description = "Yet another language server for Nix";
      homepage = "https://github.com/oxalica/nil";
      changelog = "https://github.com/oxalica/nil/releases/tag/${finalAttrs.version}";
      license = with prev.lib.licenses; [
        mit
        asl20
      ];
      maintainers = with prev.lib.maintainers; [
        oxalica
      ];
      mainProgram = "nil";
    };
  });
}
