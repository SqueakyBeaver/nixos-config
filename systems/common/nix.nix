{
  pkgs,
  config,
  inputs,
  ...
}: {
  config = {
    # we need git for flakes
    environment = {
      systemPackages = with pkgs; [
      git
      wget
      curl
      gcc
      cmake
      ];
    };

    programs.nix-ld = {
      enable = true;
      # Add as we need them
      libraries = with pkgs; [
        # List by default
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd

        # My own additions
        libXcomposite
        libXtst
        libXrandr
        libXext
        libX11
        libXfixes
        libGL
        libva
        pipewire
        libxcb
        libXdamage
        libxshmfence
        libXxf86vm
        libelf

        # Required
        glib
        gtk2

        # Inspired by steam
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
        networkmanager
        vulkan-loader
        libgbm
        libdrm
        libxcrypt
        coreutils
        pciutils
        zenity
        # glibc_multi.bin # Seems to cause issue in ARM

        # # Without these it silently fails
        libXinerama
        libXcursor
        libXrender
        libXScrnSaver
        libXi
        libSM
        libICE
        gnome2.GConf
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg
        # Only libraries are needed from those two
        libudev0-shim

        # needed to run unity
        gtk3
        icu
        libnotify
        gsettings-desktop-schemas
        # https://github.com/NixOS/nixpkgs/issues/72282
        # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
        # log in /home/leo/.config/unity3d/Editor.log
        # it will segfault when opening files if you don’t do:
        # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
        # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed

        # Verified games requirements
        libXt
        libXmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew_1_10
        libidn
        tbb

        # Other things from runtime
        flac
        freeglut
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_ttf
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        libXft
        libvdpau
        # ...
        # Some more libraries that I needed to run programs
        pango
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        alsa-lib
        expat
        # for blender
        libxkbcommon

        libxcrypt-legacy # For natron
        libGLU # For natron

        # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
        fuse
        e2fsprogs
      ];
    };

    # Taken from
    # https://github.com/FreshlyBakedCake/PacketMix/blob/main/systems/common/packetmix.nix
    # system.autoUpgrade = {
    #   enable = false;
    #   operation = "boot";
    #   flags = [
    #     "-f"
    #     "/etc/nixos/nilla.nix"
    #     "-A"
    #     "systems.nixos.${config.networking.hostName}.result"
    #   ];
    #   dates = "weekly";
    #   persistent = true;
    # };
    #
    # systemd.services.nixos-upgrade.preStart = ''
    #   ${pkgs.networkmanager}/bin/nm-online -s -q # wait until the internet is online, as esp. if we go offline we need to wait to retry...
    #   cd /etc/nixos
    #   ${pkgs.git}/bin/git fetch
    #   ${pkgs.git}/bin/git checkout origin/main
    # '';
    #
    # systemd.services.nixos-upgrade.serviceConfig = {
    #   Restart = "on-failure";
    #   RestartSec = 5;
    #   RestartSteps = 5;
    #   RestartMaxDelaySec = 86400;
    # };

    nix = {
      # package = pkgs.lix;
      gc = {
        automatic = true;
        persistent = true;
      };
      optimise.automatic = true;
      settings = {
        auto-optimise-store = true;
        builders-use-substitutes = true;
        experimental-features = ["nix-command" "flakes"];

        trusted-users = ["root" "@wheel"];

        substituters = [
          "https://cache.nixos.org"

          "https://nix-community.cachix.org"
          "https://niri.cachix.org"
          "https://noctalia.cachix.org"
          "https://attic.xuyh0120.win/lantian"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        ];
      };
    };

    system.stateVersion = "24.05";
  };
}
