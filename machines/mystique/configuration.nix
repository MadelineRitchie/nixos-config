{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  # TODO split system-specific config from config for all systems


  # BTRFS
  fileSystems = {
    "/".options = [ "compress=zstd" "noatime" ];
    "/home".options = [ "compress=zstd" "noatime" ];
    "/nix".options = [ "compress=zstd" "noatime" ];

    "/swap".options = [ "noatime" ];

    "/mnt/btrfs".options = [ "compress=zstd" "noatime" ];

    "/boot".options = [ "umask=0077" ];
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/mnt/btrfs" ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_6;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver = {
    enable = true;

    desktopManager.plasma5.enable = true;
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };

    windowManager.openbox.enable = true;
    windowManager.i3.enable = true;
    windowManager.xmonad.enable = true;

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
  };
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  networking = {
    hostName = "mystique";
    useNetworkd = true;
  };
  systemd.network = {
    enable = true;
    netdevs = {
      "20-br0" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
    };
    networks = {
      "20-wlp14s0" = {
        enable = false;
      };
      "30-enp13s0" = {
        matchConfig.Name = "en*";
        networkConfig.Bridge = "br0";
      };
      "40-br0" = {
        matchConfig.Name = "br0";
        networkConfig.DHCP = "ipv4";
        networkConfig.IPv6AcceptRA = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  security.rtkit.enable = true; # I think this is a pipewire thing?
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      deviceACL = [
        "/dev/vfio/vfio"
        "/dev/kvm"
        "/dev/kvmfr0"
        "/dev/null"
      ];
    };
  };

  users.users.madeline = {
    createHome = true;
    isNormalUser = true;
    description = "Madeline Ritchie";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "lp" "scanner" "kvm" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  users.users.root = {
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # systemd.tmpfiles.rules = [
  #   "f /dev/shm/looking-glass 0660 madeline qemu-libvirtd -"
  # ];

  programs = {
    fish.enable = true;
    dconf.enable = true; # for easyeffects service

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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
  ];

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


    easyeffects
    # looking-glass-client
    #scream
  ];

  system.stateVersion = "23.11";

}

