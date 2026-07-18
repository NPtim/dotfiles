# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  # GPU Settings
  hardware.graphics = {
    enable = true;
  };

  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # Networking 
  networking.hostName = "TODO"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # enable udisks2
  services.udisks2.enable = true;

  services.displayManager.autoLogin.enable = false;
  services.getty.autologinUser = null;

  # GNOME old window controls
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
          };

          "org/gnome/mutter" = {
            workspaces-only-on-primary = false;
          };

        };
      }

      {
      lockAll = false;
      settings = {
        "org/gnome/desktop/remote-desktop/rdp" = {
          enable = true;                         # bool
          port = pkgs.lib.gvariant.mkUint16 3389;     # <- wichtig: typisierter GVariant
          view-only = false;                     # bool
          "screen-share-mode" = "mirror-primary";# string (falls Schema vorhanden)
        };
      };
    }
    ];
  };

  programs.tmux.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "Tim";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.git.config.user.name = "NPtim";
  programs.git.config.user.email = "226116537+NPtim@users.noreply.github.com";

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/tim/dotfiles"; # TODO
  };

  security.polkit.enable = true;

  programs.htop = {
    enable = true;
    settings = {};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    pkgs.spotify
    pkgs.libreoffice-qt6-fresh
    # pkgs.signal-desktop
    pkgs.jq
    pkgs.unzip
    pkgs.obsidian
    pkgs.vlc
    # pkgs.mangohud (fps counter) :)
    # pkgs.keepass
    pkgs.iftop
    # hyprland stuff

    #pkgs.colmapWithCuda
    #pkgs-unstable.opensplatWithCuda #TODO: crashes when trying to install?

    pkgs.opendrop
    pkgs.owl
    pkgs.iw

    pkgs.kismet
    pkgs.wavemon

    pkgs.ncdu
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.zerotierone.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
