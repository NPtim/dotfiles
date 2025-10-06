{config, pkgs, ...}:

{
  programs = {
    firefox.enable = false;
    kitty = {
      enable = true;
      # themeFile = "3024_Night";
      settings = {
        cursor_trail = 1;
      };
    };
  };

  home.stateVersion = "25.05";
}
