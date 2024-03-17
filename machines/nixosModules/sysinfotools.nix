{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
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
  ];
}