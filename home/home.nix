{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "DP-2, 2560x1440@240, 0x0, 1"
        "HDMI-1, 3840x2160@60, 2560x0, 1.5"
      ];

      input = {
        kb_layout = "de";
        kb_model = "pc104";
      };

      "$terminal" = "kitty";
      "$mainMod" = "SUPER";
      "$fileManager" = "nautilus";
      "$menu" = "rofi";

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive, " 
        "bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "bind = $mainMod, R, exec, rofi -show drun"
        "bind = $mainMod, E, exec, $fileManager"

        "bind = $mainMod, V, togglefloating, "

        "bind = $mainMod, j, movefocus, l"
        "bind = $mainMod, code:47, movefocus, r"
        "bind = $mainMod, l, movefocus, u"
        "bind = $mainMod, k, movefocus, d"

        "bind = $mainMod, 1, workspace, 1"
        "bind = $mainMod, 2, workspace, 2"
        "bind = $mainMod, 3, workspace, 3"
        "bind = $mainMod, 4, workspace, 4"
        "bind = $mainMod, 5, workspace, 5"
        "bind = $mainMod, 6, workspace, 6"
        "bind = $mainMod, 7, workspace, 7"
        "bind = $mainMod, 8, workspace, 8"
        "bind = $mainMod, 9, workspace, 9"
        "bind = $mainMod, 0, workspace, 10"

        "bind = $mainMod SHIFT, 1, movetoworkspace, 1"
        "bind = $mainMod SHIFT, 2, movetoworkspace, 2"
        "bind = $mainMod SHIFT, 3, movetoworkspace, 3"
        "bind = $mainMod SHIFT, 4, movetoworkspace, 4"
        "bind = $mainMod SHIFT, 5, movetoworkspace, 5"
        "bind = $mainMod SHIFT, 6, movetoworkspace, 6"
        "bind = $mainMod SHIFT, 7, movetoworkspace, 7"
        "bind = $mainMod SHIFT, 8, movetoworkspace, 8"
        "bind = $mainMod SHIFT, 9, movetoworkspace, 9"
        "bind = $mainMod SHIFT, 0, movetoworkspace, 10"

      ];

      bindm = [
        "bindm = $mainMod, mouse:272, movewindow"
        "bindm = $mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs = {
    firefox = {
      enable = false;

      profiles.default = {
        settings = {
          "browser.startup.page" = 3;  # 3 bedeutet „Vorherige Sitzung laden“
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = false;
          "browser.sessionstore.resuming_after_os_restart" = true;
        };
      };

    };
    kitty = {
      enable = true;
      # themeFile = "3024_Night";
      settings = {
        cursor_trail = 1;
      };
    };
  };

  programs.vscode.enable = true;

  # Mail

  programs.thunderbird = {
    enable = true;
    profiles."tim" = {
      isDefault = true;
    };
  };

  home.stateVersion = "25.05";
}
