{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.satty
    pkgs.grim
    pkgs.slurp
    pkgs.hyprshot
  ];

  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, D, exec, $menu"
        "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
        "$mod, Period, exec, rofimoji"
        "$mod Alt, L, exec, hyprlock"
        "$mod SHIFT, D, exec, wlogout"

        "$mod, Q, killactive,"
        "$mod, SPACE, togglefloating,"
        "$mod, F, layoutmsg, fit active"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, G, hyprexpo:expo, toggle"

        "$mod, U, workspace, +1"
        "$mod, I, workspace, -1"
        "$mod CTRL, U, movetoworkspacesilent, +1"
        "$mod CTRL, I, movetoworkspacesilent, -1"

        "$mod, minus, layoutmsg, colresize -.1"
        "$mod, equal, layoutmsg, colresize +.1"

        "$mod, mouse_down, workspace, +1"
        "$mod, mouse_up, workspace, -1"
        "$mod SHIFT, mouse_down, layoutmsg, focus r"
        "$mod SHIFT, mouse_up, layoutmsg, focus l"

        ", Print, exec, hyprshot region -z -r | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
        "CTRL, Print, exec, hyprshot window -z -r | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
        "ALT, Print, exec, hyprshot output -z -r | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
      ]
      ++ (
        # Focus and moving windows
        builtins.concatMap (key: [
          "$mod, ${key.fst}, layoutmsg, focus ${key.snd}"
          "$mod CTRL, ${key.fst}, layoutmsg, movewindowto ${key.snd}"
        ]) (lib.lists.zipLists ["H" "J" "K" "L"] ["l" "d" "u" "r"])
      )
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod CTRL, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
            ]
          )
          9)
      );

    binde = [
      # Zoom
      "$mod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
      "$mod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
    ];

    bindm = [
      "$mod, mouse:272, resizewindow"
      "ALT, mouse:272, movewindow"
      "ALT, mouse:272, togglefloating"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86MicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF85MonBrightnessUp, exec, brightnessctl s 5%+"
      ", XF85MonBrightnessDown, exec, brightnessctl s 5%-"
    ];
  };
}
