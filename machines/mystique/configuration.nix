{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../shared.nix
    ];

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

  # maybe I want every nix machine to use systemd and efi but maybe not
  boot = {
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
        #networkConfig.IPv6AcceptRA = true;
      };
    };
  };

  system.stateVersion = "23.11";
}
