{
  config,
  pkgs,
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
          };
          # Emacs will destroy my pinky ;-;
          alt = {
            capslock = "leftcontrol";
          };
        };
      };

      trackball-mouse = {
        ids = [
          "056e:010d:f02f9ad5"
        ];

        settings = {
          main = {
            mouse2 = "forward";
            mouse1 = "back";
            mouseforward = "M-h";
            mouseback = "M-l";
          };
        };
      };
    };
    # input-remapper = {
    #   enable = true;
    #   enableUdevRules = true; # Might cause issues
    # };
  };
}
