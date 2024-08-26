{
  pkgs,
  lib,
  stdenv,
  android-tools,
  cacert,
  fetchFromGitHub,
  makeDesktopItem,
  # pyinstaller ? false,
  python311,
  substituteAll,
  wrapGAppsHook,
  gtk3,
  glib,
  gsettings-desktop-schemas,
  gsettings-qt,
  namespace,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pixelflasher";
  # I'd rather not make the package name capitalized, but the installer wants it to be
  ppname = "PixelFlasher";
  version = "7.3.2.0";

  src = fetchFromGitHub {
    owner = "badabing2005";
    repo = "PixelFlasher";
    rev = "v${finalAttrs.version}";
    hash = "sha256-U7fZ3Tx5TjYTus6IwOW9gAejY6jn7weGwcnyfS7IGSc=";
  };

  phases = [
    "unpackPhase"
    "buildPhase"
    "installPhase"
    "fixupPhase"
  ];

  buildPhase = ''
    # https://github.com/pyinstaller/pyinstaller/issues/1684#issuecomment-590288201
    sed -i 's/hiddenimports=\[\]/hiddenimports=\["_cffi_backend"\]/' build-on-*.spec

    # we set the default android-tools path for convenience
    sed -i 's#platform_tools_path = None#platform_tools_path = "${android-tools}\/bin"#' config.py

    sh build.sh
  '';

  installPhase = ''
    # AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    mkdir -p $out/bin/ $out/share dist

    install -D dist/${finalAttrs.ppname} $out/bin

    install -D images/icon-dark-256.png $out/share/pixmaps/${finalAttrs.ppname}.png

    ln -s ${finalAttrs.desktopItem}/share/applications $out/share/
  '';

  fixupPhase = ''
    ls -lh $out/bin
    wrapProgram $out/bin/${finalAttrs.ppname} \
      --set REQUESTS_CA_BUNDLE "${cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  pyinstaller = pkgs.${namespace}.pyinstaller;

  buildInputs = with python311.pkgs; [
    android-tools
    attrdict
    beautifulsoup4
    bsdiff4
    chardet
    cryptography
    darkdetect
    httplib2
    json5
    lz4
    markdown
    platformdirs
    protobuf
    psutil
    pyinstaller
    pyinstaller-versionfile
    pyperclip
    requests
    rsa
    six
    wxpython
    gtk3
    glib
    gsettings-desktop-schemas
    gsettings-qt
    wrapGAppsHook
  ];

  desktopItem = makeDesktopItem {
    name = finalAttrs.pname;
    exec = finalAttrs.pname;
    icon = finalAttrs.pname;
    desktopName = finalAttrs.pname;
    categories = ["Utility"];
    genericName = finalAttrs.meta.description;
    noDisplay = false;
    startupNotify = true;
    terminal = false;
    type = "Application";
  };

  meta = {
    description = "Pixel™ phone flashing GUI utility with features";
    homepage = "https://github.com/badabing2005/PixelFlasher";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "PixelFlasher";
    platforms = lib.platforms.all;
  };
})
