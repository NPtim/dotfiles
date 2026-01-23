{config, pkgs, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''this is a test for the config with another word'';
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
