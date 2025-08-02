{ config, lib, pkgs, inputs, ... }:

let
  picomConfigPath = "/home/quqin/dotfiles/config/picom/picom.conf";  # Make sure the path is correct
  nvidiaUtils = import ../../system/nvidia/nvidiaUtils.nix { inherit pkgs lib; };
in
{
  imports =
  [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../shared

    ../../system/nvidia
    ../../system/battery
    ../../system/audio
  ];

  home-manager = {
    extraSpecialArgs = { inherit nvidiaUtils inputs; };
    backupFileExtension = "backup";

    users = {
      "quqin" = import ./home.nix;
    };
  };

  nix = {
    settings.experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];

    # Changes the default nixPath.
    # Check changes with `echo $NIX_PATH`
    nixPath = [
      "nixos-config=/home/quqin/dotfile/hosts/quqin/configuration.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  nixpkgs.config = { 
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"

      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
  };

  boot = {
    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;

    # Use the systemd-boot EFI boot loader. And Dual Boot with window
    loader = {
      systemd-boot = { 
        enable = true;
        xbootldrMountPoint = "/boot";
      };

      efi = { 
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
    };
  };

  networking = {
    hostName = "personal"; # Define hostname.

    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Set time zone.
  time.timeZone = "Asia/Jakarta";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.awesome.enable = true;

  	displayManager.sessionCommands = ''
  	  picom --config ${picomConfigPath} -b
	  xrandr --output eDP-1 --brightness 0.5
  	'';
  };

  services = {
    # Configure keymap in X11
    xserver.xkb.layout = "us";

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Default
    vim
    wget

    # Power Management
    powertop

    picom
    nh

    pamixer
    pavucontrol
    helvum
    libnotify
  ];

  # List programs are being used

  programs.firefox = { enable = true; };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # List services are being enable

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    extraConfig = ''
      AllowAgentForwarding no
      PasswordAuthentication no
      X11Forwarding no
    '';
  };

  services.udev.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment? Nope
}

