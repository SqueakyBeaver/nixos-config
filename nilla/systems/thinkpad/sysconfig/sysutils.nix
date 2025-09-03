{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.appimage-run

    pkgs.lutris
    pkgs.mangohud
    pkgs.protonup-qt

    pkgs.podman-compose
    pkgs.docker-compose
  ];

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig = {
        "10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-hw-volume" = true;
          };
        };
        "11-bluetooth-policy" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
    };

    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    #   settings = {
    #     mysqld = {
    #       lower_case_table_names = 1;
    #     };
    #   };
    # };

    flatpak.enable = true;
    colord.enable = true;
    fwupd.enable = true;
  };

  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
    # virt-manager.enable = true;
    gamemode = {
      enable = true;
      enableRenice = true;
    };

    # Use android tablet as a sort of drawing tablet
    weylus = {
      enable = true;
      openFirewall = true;
      users = ["beaver"];
    };
  };

  virtualisation = {
    # libvirtd.enable = true;
    # spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };
  };

  # I don't want it auto-started tbh
  # systemd.services.plantuml-server.wantedBy = pkgs.lib.mkOverride 0 [];

  environment.variables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  hardware = {
    # xpadneo.enable = true;
    graphics.enable32Bit = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          KernelExperimental = true;
          MultiProfile = "multiple";
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    amdgpu.opencl.enable = true;
    # amdgpu.overdrive.enable = true;
  };
}
