# Options in this folder

All options are prefaced by the snowfall namescpace
For example `browser.enable` would be `timber.browser.enable` if the snowfall namescpace is `timber`

## `home` folder
| Option                    | Default | Example | Location              | Explanation                                                                       |
|---------------------------|---------|---------|-----------------------|-----------------------------------------------------------------------------------|
| `browser.enable`          | `false` | `true`  | `browser/default.nix` | Whether to enable browser                                                         |
| `browser.firefox.enable`  | `true`  | `false` | `browser/default.nix` | Whether to enable firefox                                                         |
| `browser.chromium.enable` | `false` | `true`  | `browser/default.nix` | Whether to enable ungoogled chromium                                              |
| `editors.enable`          | `false` | `true`  | `editors/default.nix` | Whether to enable graphical editors                                               |
| `editors.codium.enable`   | `true`  | `false` | `editors/default.nix` | Whether to enable vscodium with some extensions (will be custimizable eventually) |
| `editors.android.enable`  | `false` | `true`  | `editors/default.nix` | Whether to enable android studio                                                  |


## `nixos` folder
| Option                  | Default | Example | Location              | Explanation                                                    |
|-------------------------|---------|---------|-----------------------|----------------------------------------------------------------|
| `audio.enable`          | `false` | `true`  | `audio/default.nix`   | Whether to enable the pipewire service                         |
| `desktop.plasma.enable` | `false` | `true`  | `desktop/default.nix` | Whether to use KDE plasma 6                                    |
| `games.enable`          | `false` | `true`  | `games/default.nix`   | Whether to enable some gaming stuff, like Steam and Proton     |
| `games.optimize.enable` | `true`  | `false` | `games/default.nix`   | Whether to enable kernel optimizations that the steam deck has |
| `xdg.enable`            | `false` | `true`  | `xdg/default.nix`     | Whether to enable xdg-open                                     |
