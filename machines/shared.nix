{ pkgs, ... }:
{
  nix = {
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    package = pkgs.nixFlakes;
    settings = {
      # Automate `nix store --optimise`
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];
      
      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    };
  };
  
  boot = {
    kernelPackages = pkgs.linuxPackages_6_6;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # gnome.gnome-keyring.enable = true;
    # upower.enable = true;

    openssh = {
      enable = true;
      allowSFTP = true;
    };
    # SSH daemon.
    sshd.enable = true;


    # libinput = {
    #   enable = true;
    #   touchpad.disableWhileTyping = true;
    # };
    
    # dbus = {
    #   enable = true;
    #   packages = [ pkgs.dconf ];
    # };
    
    # desktopManager.plasma6.enable = true;
    
    # picom = {
    #   enable = true;
    # };
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      
      # serverLayoutSection = ''
      #   Option "StandbyTime" "0"
      #   Option "SuspendTime" "0"
      #   Option "OffTime"     "0"
      # '';

      # displayManager = {
      #   defaultSession = "none+xmonad";
      # };
  
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
  
      displayManager.sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  # systemd.services.upower.enable = true;
  
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

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

  programs = {
    fish.enable = true;
    dconf.enable = true; # for easyeffects service and other things

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
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
  ];

  environment.systemPackages = with pkgs; [
    ## cli
    wget
    git
    tmux
    tldr
    htop
    most

    ## gui
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
    lm_sensors
    smartmontools

    easyeffects
  ];

}
