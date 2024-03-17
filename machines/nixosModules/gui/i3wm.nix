{ pkgs, ... }:
{
  services.picom.enable = true;
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
#      xfce = {
#        enable = true;
#        noDesktop = true;
#        enableXfwm = false;
#      };
    };
    windowManager.i3.enable = true;
  };
}