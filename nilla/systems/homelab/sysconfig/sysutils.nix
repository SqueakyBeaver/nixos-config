{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.podman-compose
    pkgs.docker-compose
    pkgs.ssh-to-age
  ];

  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        };
      };
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;
      settings = {
        mysqld = {
          lower_case_table_names = 1;
        };
      };
    };

    flatpak.enable = true;
    colord.enable = true;
    
    fwupd.enable = true;
  };

  programs = {
    virt-manager.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };
  };

  # I don't want it auto-started tbh
  systemd.services.plantuml-server.wantedBy = pkgs.lib.mkOverride 0 [];

  environment.variables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };
}
