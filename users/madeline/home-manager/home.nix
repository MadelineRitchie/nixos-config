{ config, pkgs, ... }:
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
    obsidian
    jetbrains.rider
    ungoogled-chromium
    vscode.fhs
    cinny-desktop
    vesktop
    strawberry-qt6
    jdk17
    looking-glass-client
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

  imports = [
    ./shared.nix
  ];

  nixpkgs.overlays = [
    (final: prev:
    {
      looking-glass-client = prev.looking-glass-client.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "gnif";
          repo = "LookingGlass";
          rev = "eb31815b";
          hash = "sha256-T+CmhWv9C0ZdplAUr7SROtemjAVFvqJZNJ5PulKWfA4=";
          fetchSubmodules = true;
        };
      });
    }
    )
  ];

  home.stateVersion = "23.11";
}
