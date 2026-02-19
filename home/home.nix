{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "DP-2, 2560x1440@240, 0x0, 1"
        "HDMI-1, 3840x2160@60, 2560x0, 1.5"
      ];

      exec-once = [
        "systemctl --user start hyprpolkitagent"
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
        "$mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "$mainMod, D, exec, pkill rofi || rofi -show drun"
        "$mainMod, E, exec, $fileManager"
        "$mainMod SHIFT, L, exec, hyprlock"

        "$mainMod, V, togglefloating, "

        "$mainMod, j, movefocus, l"
        "$mainMod, code:47, movefocus, r"
        "$mainMod, l, movefocus, u"
        "$mainMod, k, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
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
