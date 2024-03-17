{ pkgs, ... }:
{
  security.rtkit.enable = true; # I think this is a pipewire thing?
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver = {
    enable = true;
#     deviceSection = ''
#       Option "TearFree" "true"
#     '';

#    windowManager.xmonad = {
#      enable = true;
#      enableContribAndExtras = true;
#    };

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
  };
  
  imports = [
    ./sway.nix
    #./i3wm.nix
    #./plasma.nix
    ./hyprland.nix
  ];
}
