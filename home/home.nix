{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "DP-2, 2560x1440@240, 0x0, 1"
        "HDMI-1, 3840x2160@60, 2560x0, 1.5"
      ];

      "$terminal" = "kitty";
      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "bind = $mainMod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
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
