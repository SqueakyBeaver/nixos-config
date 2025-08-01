{
  pkgs,
  lib,
  ...
}: {
  boot = {
    plymouth = {
      enable = false;
      theme = lib.mkForce "blahaj";
      themePackages = with pkgs; [
        # By default we would install all themes
        # (adi1090x-plymouth-themes.override {
        #   selected_themes = ["rings_2" "cuts" "ibm"];
        # })

        plymouth-blahaj-theme
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
