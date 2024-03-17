{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  environment.systemPackages = with pkgs; [
    wofi
    dolphin
  ];
  qt = {
    enable = true;
    style = "adwaita-dark";
  };
}
