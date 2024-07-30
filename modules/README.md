# Options in this folder

All options are prefaced by the snowfall namescpace
For example `browser.enable` would be `timber.browser.enable` if the snowfall namescpace is `timber`

## `home` folder
| Option                    | Default | Location              | Explanation                                                                         |
|---------------------------|---------|-----------------------|-------------------------------------------------------------------------------------|
| `browser.enable`          | `false` | `browser/default.nix` | Whether to enable browser                                                           |
| `browser.firefox.enable`  | `true`  | `browser/default.nix` | Whether to enable firefox                                                           |
| `browser.chromium.enable` | `false` | `browser/default.nix` | Whether to enable ungoogled chromium                                                |
| `editors.enable`          | `false` | `editors/default.nix` | Whether to enable graphical editors                                                 |
| `editors.codium.enable`   | `true`  | `editors/default.nix` | Whether to enable vscodium with some extensions (will be custimizable eventually)   |
| `editors.android.enable`  | `false` | `editors/default.nix` | Whether to enable android studio                                                    |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |
| `apps.enable`             | `true`  | `apps/default.nix`    | Whether to allow using various graphical applications (not recommended for servers) |


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