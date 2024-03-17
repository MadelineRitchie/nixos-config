{ pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };


  programs = {
    fish.enable = true;
    dconf.enable = true; # for easyeffects service and other things

    virt-manager.enable = true;
    #<suid>
    # enables SUID wrappers for stuff that needs admin rights
    # I think I enabled these two for virt-manager
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    #</suid>
  };
  
  hardware.keyboard.zsa.enable = true;

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

    easyeffects
  ];
  
  imports = [
    ./nixosModules
  ];
}
