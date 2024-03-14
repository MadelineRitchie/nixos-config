{ config, pkgs, lib, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  home.username = "madeline";
  home.homeDirectory = "/home/madeline";

  home.packages = with pkgs; [
    obsidian #note workstation
    jetbrains.rider #IDE
    ungoogled-chromium
    cinny-desktop
    vesktop #discord
    strawberry-qt6 #music player
    looking-glass-client
    obs-studio
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  services.easyeffects = {
    enable = true;
    preset = "bass ofc";
  };

  nixpkgs.overlays = [
    (final: prev: {
      looking-glass-client = prev.looking-glass-client.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "gnif";
          repo = "LookingGlass";
          rev = "13b9756e";
          hash = "sha256-Oom4G6eytlzDbviLRVtuj+EfTBBeRGUL4O0qSDSejv8=";
          fetchSubmodules = true;
        };
      });
    })
  ];
  
  # imports =  [
  imports = [
    ./shared.nix
  ];

  home.stateVersion = "23.11";
}
