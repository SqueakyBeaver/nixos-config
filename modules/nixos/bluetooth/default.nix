{
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
      };
    };
  };
}
