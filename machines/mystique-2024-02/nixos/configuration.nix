{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # BTRFS
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [
        "vfio-pci"
      ];
    };
  };

  networking.hostName = "mystique";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.xserver = {
    enable = true;
    # videoDrivers = ["amdgpu"];

    desktopManager.plasma5.enable = true;

    displayManager.defaultSession = "plasmawayland";
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
  };
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  security.rtkit.enable = true; # I think this is a pipewire thing?
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.madeline = {
    isNormalUser = true;
    description = "Madeline Ritchie";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  users.users.root = {
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };

  programs = {
    fish.enable = true;

    virt-manager.enable = true;
    partition-manager.enable = true;

    #<suid>
    # enables SUID wrappers for stuff that needs admin rights
    # I think I enabled these two for virt-manager
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    #</suid>
  
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "madeline" ];
    };

    firefox = {
      enable = true;
      preferences = {
        # "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };

    steam = {
      enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## cli
    wget
    git
    tmux
    tldr
    htop
    most

    ## gui
    kitty
    #xwayland # wonder if this is a dang default
    vesktop
    #wl-clipboard #wl-copy and wl-paste

    # info tools
    usbutils #lsusb and such
    pciutils
    wayland-utils
    clinfo
    libva-utils
    glxinfo
    vulkan-tools
    inxi
    xorg.xdpyinfo
    bluez-tools
    dmidecode
    doas
    bluez
    file
    hddtemp
    ipmitool
    freeipmi
    mdadm
    # busybox
    lm_sensors
    smartmontools


    looking-glass-client
    #scream
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

}

