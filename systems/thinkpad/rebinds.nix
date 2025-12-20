{
  config,
  pkgs,
  lib,
  system,
  ...
}: {
  services.keyd = {
    enable = true;

    keyboards = {
      keyboard = {
        ids = [
          "*"
        ];

        settings = {
          main = {
            capslock = "backspace";
            rightshift = "rightshift";
          };
        };
      };

      trackball-mouse = {
        ids = [
          "056e:010d:f02f9ad5"
          "056e:010d:1989813c"
        ];

        settings = {
          main = {
            mouse2 = "forward";
            mouse1 = "back";
            mouseforward = "M-h";
            mouseback = "M-l";
            f18 = "middlemouse";
          };
        };
      };
    };
    # input-remapper = {
    #   enable = true;
    #   enableUdevRules = true; # Might cause issues
    # };
  };

  environment.systemPackages = [
    pkgs.keyd
  ];

  systemd.services.keyd.serviceConfig = {
    group = "keyd";
    RestrictRealtime = lib.mkForce false;
  };
}
