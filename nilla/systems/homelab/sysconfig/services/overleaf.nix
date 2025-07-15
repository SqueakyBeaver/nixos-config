# Auto-generated using compose2nix v0.3.1.
{
  pkgs,
  lib,
  project,
  ...
}: let
  ports.overleaf = 6969;
in {
  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman*".allowedUDPPorts = [53];

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      "mongo" = {
        image = "mongo:noble";
        environment = {
          "MONGO_INITDB_DATABASE" = "sharelatex";
        };
        volumes = [
          "/home/otter/overleaf/mongo_data:/data/db:rw"
          "${./mongodb-init-replica-set.js}:/docker-entrypoint-initdb.d/mongodb-init-replica-set.js"
        ];
        cmd = ["--replSet" "overleaf" "--quiet"];
        log-driver = "journald"; # STOP FLOODING MY JOURNAL
        extraOptions = [
          "--add-host=mongo:127.0.0.1"
          "--expose=27017"
          "--health-cmd=echo 'db.stats().ok' | mongosh localhost:27017/test --quiet"
          "--health-interval=10s"
          "--health-retries=5"
          "--health-timeout=10s"
          "--network-alias=mongo"
          "--network=overleaf_default"
        ];
      };
      "redis" = {
        image = "docker.io/valkey/valkey:alpine";
        volumes = [
          "/home/otter/overleaf/redis_data:/data:rw"
        ];
        log-driver = "journald";
        extraOptions = [
          "--expose=6379"
          "--network-alias=redis"
          "--network=overleaf_default"
        ];
      };
      "sharelatex" = {
        # *sigh* I need more latex packages
        image = "overleaf:latest";
        imageFile = pkgs.dockerTools.buildImage {
          name = "overleaf";
          tag = "latest";

          fromImage = pkgs.dockerTools.pullImage {
            imageName = "sharelatex/sharelatex";
            imageDigest = "sha256:a9b671a7f751042afbc059060459f5c9a63a3dfeda365a480bc8db1c6eb5a063";
            sha256 = "sha256-cesepVuhnZ/0uCCVFqtUuodoRPgucrDTyl747o8Nr3k=";
          };

          copyToRoot = pkgs.buildEnv {
            name = "texlive-full";
            paths = [pkgs.texliveFull];
            # /bin is a symlink to /usr/bin on Debian, add a prefix to avoid replacing original `/bin`
            extraPrefix = "/usr";
            postBuild = ''
              if [[ -d "$out/usr/etc" ]] ; then
                mv $out/usr/etc $out/etc
              fi
              # Overleaf makes /usr/local/bin the first in PATH
              # Fuck Overleaf
              mkdir -p $out/usr/local/bin
              for i in $( ls "$out/usr/bin/") ; do 
                ln -sf "$out/usr/bin/$i" "$out/usr/local/bin/$i"
              done
            '';
          };
        };

        environment = {
          EMAIL_CONFIRMATION_DISABLED = "true";
          ENABLE_CONVERSIONS = "true";
          ENABLED_LINKED_FILE_TYPES = "project_file,project_output_file";
          GIT_BRIDGE_ENABLED = "false";
          OVERLEAF_APP_NAME = "Overleaf";
          OVERLEAF_BEHIND_PROXY = "true";
          OVERLEAF_LISTEN_IP = "0.0.0.0";
          OVERLEAF_PORT = "${builtins.toString ports.overleaf}";
          OVERLEAF_MONGO_URL = "mongodb://mongo/sharelatex";
          OVERLEAF_REDIS_HOST = "redis";
          OVERLEAF_SITE_URL = "https://overleaf.801687692.xyz";
          REDIS_HOST = "redis";
          REDIS_PORT = "6379";
        };
        volumes = [
          "/home/otter/overleaf/data:/var/lib/overleaf:rw"
        ];
        ports = [
          "0.0.0.0:${builtins.toString ports.overleaf}:80/tcp"
        ];
        dependsOn = [
          "mongo"
          "redis"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=sharelatex"
          "--network=overleaf_default"
        ];
        entrypoint = "/sbin/my_init";
      };
    };
  };

  # Containers
  systemd.services."podman-mongo" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-overleaf_default.service"
    ];
    requires = [
      "podman-network-overleaf_default.service"
    ];
    partOf = [
      "podman-compose-overleaf-root.target"
    ];
    wantedBy = [
      "podman-compose-overleaf-root.target"
    ];
  };

  systemd.services = {
    "podman-redis" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-overleaf_default.service"
      ];
      requires = [
        "podman-network-overleaf_default.service"
      ];
      partOf = [
        "podman-compose-overleaf-root.target"
      ];
      wantedBy = [
        "podman-compose-overleaf-root.target"
      ];
    };

    "podman-overleaf" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-overleaf_default.service"
      ];
      requires = [
        "podman-network-overleaf_default.service"
      ];
      partOf = [
        "podman-compose-overleaf-root.target"
      ];
      wantedBy = [
        "podman-compose-overleaf-root.target"
      ];
    };

    # Networks
    "podman-network-overleaf_default" = {
      path = [pkgs.podman];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f overleaf_default";
      };
      script = ''
        podman network inspect overleaf_default || podman network create overleaf_default
      '';
      partOf = ["podman-compose-overleaf-root.target"];
      wantedBy = ["podman-compose-overleaf-root.target"];
    };
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-overleaf-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = ["multi-user.target"];
  };
}
