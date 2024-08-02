# Options in this directory

All options are prefaced by the snowfall namescpace
For example `browser.enable` would be `timber.browser.enable` if the snowfall namescpace is `timber`

## `home/` directory
| Option                          | Default                | Location                         | Explanation                                     |
| ------------------------------- | ---------------------- | -------------------------------- | ----------------------------------------------- |
| `browser.enable`                | `false`                | `browser/default.nix`            | Whether to enable browser                       |
| `browser.firefox.enable`        | `true`                 | `browser/default.nix`            | Whether to enable firefox                       |
| `browser.chromium.enable`       | `false`                | `browser/default.nix`            | Whether to enable ungoogled chromium            |
| `editors.enable`                | `false`                | `editors/default.nix`            | Whether to enable graphical editors             |
| `editors.codium.enable`         | `true`                 | `editors/default.nix`            | Whether to enable vscodium with some extensions |
| `editors.android.enable`        | `false`                | `editors/default.nix`            | Whether to enable android studio                |
| `apps.bitwarden.enable`         | `false`                | `apps/bitwarden/default.nix`     | Whether to install Bitwarden                    |
| `apps.graphics.enable`          | `false`                | `apps/graphics/default.nix`      | Whether to install graphics apps (GIMP)         |
| `apps.graphics.gimp.enable`     | `apps.graphics.enable` | `apps/graphics/default.nix`      | Whether to install GIMP                         |
| `apps.graphics.krita.enable`    | `false`                | `apps/graphics/default.nix`      | Whether to install Krita                        |
| `apps.graphics.inkscape.enable` | `false`                | `apps/graphics/default.nix`      | Whether to install Inkscape                     |
| `apps.obsidian.enable`          | `false`                | `apps/obsidian/default.nix`      | Whether to install obsidian                     |
| `apps.prismlauncher.enable`     | `false`                | `apps/prismlauncher/default.nix` | Whether to install prism launcher               |
| `apps.spotify.enable`           | `false`                | `apps/spotify/default.nix`       | Whether to install spotify                      |
| `apps.vesktop.enable`           | `false`                | `apps/vesktop/default.nix`       | Whether to install vesktop                      |
| `apps.vlc.enable`               | `false`                | `apps/vlc/default.nix`           | Whether to install vlc                          |


## `nixos/` directory
| Option                          | Default | Location                | Explanation                                                    |
| ------------------------------- | ------- | ----------------------- | -------------------------------------------------------------- |
| `audio.enable`                  | `false` | `audio/default.nix`     | Whether to enable the pipewire service                         |
| `bluetooth.enable`              | `false` | `bluetooth/default.nix` | Whether to enable bluetooth on the machine                     |
| `desktop.plasma.enable`         | `false` | `desktop/default.nix`   | Whether to use KDE plasma 6                                    |
| `games.enable`                  | `false` | `games/default.nix`     | Whether to enable some gaming stuff, like Steam and Proton     |
| `games.optimize`                | `false` | `games/default.nix`     | Whether to enable kernel optimizations that the steam deck has |
| `xdg.enable`                    | `false` | `xdg/default.nix`       | Whether to enable xdg-open                                     |
| `networking.tailscale.enable`   | `true`  | `tailscale/default.nix` | Whether to enable the tailscale service                        |
| `networking.tailscale.exitNode` | `false` | `tailscale/default.nix` | Whether to make the device a tailscale exit node               |
| `networking.tailscale.useSSH`   | `true`  | `tailscale/default.nix` | Whether to use tailscale for ssh authentication                |
| `virtualisation.enable`         | `false` | `tailscale/default.nix` | Whether to enable virtualisation using virt-manager            |
| `printing.enable`               | `false` | `tailscale/default.nix` | Whether to enable printing                                     |
| `printing.openFirewall`         | `true`  | `tailscale/default.nix` | Whether to enable searching for printers over the network      |
