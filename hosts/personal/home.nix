{ config, lib, pkgs, nvidiaUtils, ... }:

{
  imports = [
    ../../user/kitty
    ../../user/fish
    ../../user/nvim
  ];

  home = {
    username = "quqin";
    homeDirectory = "/home/quqin";

    stateVersion = "25.05";

    packages = with pkgs; [
      # Terminal
      kitty

      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji

      # Compression
      zip
      unzip

      # File Manager
      yazi # Terminal

      # Tools
      neofetch
      tree

      # Application Launcher
      rofi

      nix-output-monitor

      # Programs Inspection
      btop

      # Battery 
      acpi

      # Tools for working with usb and pci devices
      pciutils
      usbutils

      # Clipboard
      xclip

      # Programming Language
      gnumake
      libgcc
      gcc
      pkg-config

      git-filter-repo
      dconf
      lxappearance
    ]; 

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".config/awesome" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/quqin/dotfiles/config/awesome";
        recursive = true;
      };
    };

    sessionVariables = {
      # QT_QPA_PLATFORMTHEME = "gtk3";  # or "qt5ct"
      EDITOR = "nvim";
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-gtk-theme;
    };

    cursorTheme = {
      name = "volantes_cursors";
      package = pkgs.volantes-cursors;
      size = 17;
    };

    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = "1";
    };
  };

  xresources.properties = {
    "Xcursor.size" = 17;
    "Xft.dpi" = 170;
  };

  programs.git = {
    enable = true;
    userName = "Quqin";
    userEmail = "123801485+Quqin917@users.noreply.github.com";
    
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.bash = { 
    enable = true;

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
      	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      	exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi

      export XDG_DATA_HOME="$HOME/.local/share"
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
