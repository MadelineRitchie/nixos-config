{ pkgs, ... }:
{
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
}