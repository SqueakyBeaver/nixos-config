{ inputs, config, self, ... }:
{
  imports = [
    # ./ags
    ./media
    ./system
    ./wayland
  ];
}
