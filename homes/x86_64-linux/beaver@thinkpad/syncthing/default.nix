{
  config,
  namespace,
  lib,
  ...
}: {
  services.syncthing = let
    # I am so sad that I have to do it like this, but oh well
    devices = (lib.modules.importJSON config.sops.secrets.beaver_thinkpad_syncthing_devices.path).config;
    folders = (lib.modules.importJSON config.sops.secrets.beaver_thinkpad_syncthing_folders.path).config;
  in {
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
          devices = [];
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
