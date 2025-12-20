{
  config,
  lib,
  ...
}: {
  services.syncthing = {
    enable = true; # Shouldn't be needed (?) but just in case
    cert = config.sops.secrets.beaver_thinkpad_syncthing_cert.path;
    key = config.sops.secrets.beaver_thinkpad_syncthing_key.path;
    settings = {
      devices = {
        "phone" = {
          id = "OZ5MDV3-DL3R3QB-TDPLSM5-L6OQIM7-JWL6SE6-HPCSYOY-NCT5HER-TBNRGAC";
        };

        "thinkpad" = {
          id = "NVXPD5G-4ZYQLJ5-TYOUWIU-GWAXLIU-7CRVDSF-GIWNQI5-JKT34SL-RNUKNQA";
        };
      };

      folders = {
        "/home/beaver/Documents/sync" = {
          label = "documents";
          devices = [
            "phone"
          ];
        };

        "/home/beaver/Music" = {
          label = "music";
          devices = [
            "phone"
          ];
        };

        "/home/beaver/Coding" = {
          label = "coding";
          devices = [ ];
        };

        "/home/beaver/org" = {
          label = "org-notes";
          devices = [
            "phone"
          ];
        };

        "/home/beaver/Classes" = {
          label = "classes";
          devices = [
            "phone"
          ];
        };
      };
    };
  };

  sops.secrets.beaver_thinkpad_syncthing_cert = {
    sopsFile = ./cert.sops.beaver.pem.bin;
    mode = "0400";
    format = "binary";
  };

  sops.secrets.beaver_thinkpad_syncthing_key = {
    sopsFile = ./key.sops.beaver.pem.bin;
    mode = "0400";
    format = "binary";
  };
}
