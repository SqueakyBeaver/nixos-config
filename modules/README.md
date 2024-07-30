# Options in this folder

All options are prefaced by the snowfall namescpace
For example `browser.enable` would be `timber.browser.enable` if the snowfall namescpace is `timber`

## `home` folder
| Option                          | Default       | Location                         | Explanation                                                         |
|---------------------------------|---------------|----------------------------------|---------------------------------------------------------------------|
| `browser.enable`                | `false`       | `browser/default.nix`            | Whether to enable browser                                           |
| `browser.firefox.enable`        | `true`        | `browser/default.nix`            | Whether to enable firefox                                           |
| `browser.chromium.enable`       | `false`       | `browser/default.nix`            | Whether to enable ungoogled chromium                                |
| `editors.enable`                | `false`       | `editors/default.nix`            | Whether to enable graphical editors                                 |
| `editors.codium.enable`         | `true`        | `editors/default.nix`            | Whether to enable vscodium with some extensions                     |
| `editors.android.enable`        | `false`       | `editors/default.nix`            | Whether to enable android studio                                    |
| `apps.enable`                   | `true`        | `apps/default.nix`               | Whether to install misc. applications (not recommended for servers) |
| `apps.bitwarden.enable`         | `apps.enable` | `apps/bitwarden/default.nix`     | Whether to install Bitwarden                                        |
| `apps.graphics.enable`          | `apps.enable` | `apps/graphics/default.nix`      | Whether to install graphics apps (GIMP)                             |
| `apps.graphics.gimp.enable`     | `true`        | `apps/graphics/default.nix`      | Whether to install GIMP                                             |
| `apps.graphics.krita.enable`    | `false`       | `apps/graphics/default.nix`      | Whether to install Krita                                            |
| `apps.graphics.inkscape.enable` | `false`       | `apps/graphics/default.nix`      | Whether to install Inkscape                                         |
| `apps.obsidian.enable`          | `apps.enable` | `apps/obsidian/default.nix`      | Whether to install obsidian                                         |
| `apps.prismlauncher.enable`     | `apps.enable` | `apps/prismlauncher/default.nix` | Whether to install prism launcher                                   |
| `apps.spotify.enable`           | `apps.enable` | `apps/spotify/default.nix`       | Whether to install spotify                                          |
| `apps.vesktop.enable`           | `apps.enable` | `apps/vesktop/default.nix`       | Whether to install vesktop                                          |
| `apps.vlc.enable`               | `apps.enable` | `apps/vlc/default.nix`           | Whether to install vlc                                              |


## `nixos` folder
| Option                          | Default | Location                | Explanation                                                    |
|---------------------------------|---------|-------------------------|----------------------------------------------------------------|
| `audio.enable`                  | `false` | `audio/default.nix`     | Whether to enable the pipewire service                         |
| `desktop.plasma.enable`         | `false` | `desktop/default.nix`   | Whether to use KDE plasma 6                                    |
| `games.enable`                  | `false` | `games/default.nix`     | Whether to enable some gaming stuff, like Steam and Proton     |
| `games.optimize.enable`         | `true`  | `games/default.nix`     | Whether to enable kernel optimizations that the steam deck has |
| `xdg.enable`                    | `false` | `xdg/default.nix`       | Whether to enable xdg-open                                     |
| `networking.tailscale.enable`   | `true`  | `tailscale/default.nix` | Whether to enable the tailscale service                        |
| `networking.tailscale.exitNode` | `false` | `tailscale/default.nix` | Whether to make the device a tailscale exit node               |