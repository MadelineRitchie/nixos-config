{ config, pkgs, lib, ... }:
let
  lookingGlassGitHubOptions = {
    owner = "gnif";
    repo = "LookingGlass";
    rev = "23b773ad";
    hash = "sha256-M6PFujDZVjmj1HbCCi5NKhzgJjnNypHA/eN0R11numQ=";
    fetchSubmodules = true;
  };
in
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
    jetbrains.clion
    ungoogled-chromium
    cinny-desktop
    vesktop #discord
    strawberry-qt6 #music player
    looking-glass-client
    keymapp #moonlander flashing
    pavucontrol #volume control
    arandr #desktop organization shits but only in i3
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
        src = prev.fetchFromGitHub lookingGlassGitHubOptions;
      });
    })
    
#    (final: prev: {
#      jetbrains.rider = prev.jetbrains.rider.overrideAttrs (old: {
#        src = prev.fetchFromGitHub {
#          owner = "sdht0";
#          repo = "nixpkgs";
#          rev = "000774b8e92b620ce975fc72b7c81c6100d9a170";
#          # hash = "sha256-yVEwUPmbna9y3Q1w1nj6RPEdh5Npb+tZBEm2OwqfWfE=";
#        };
#      });
#    })
  ];
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        # wlrobs
        # obs-backgroundremoval
        obs-pipewire-audio-capture
        looking-glass-obs
      ];
    };
  };
  
  imports = [
    ./shared.nix
  ];

  home.stateVersion = "23.11";
}
