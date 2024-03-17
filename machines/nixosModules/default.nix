{ pkgs, ... }:
{
  imports = [
  ./kernel.nix
  ./users.nix
  
  ./ssh.nix
  ./nix.nix
  ./sysinfotools.nix
  
  ./gui
  
  ./desktop-apps.nix
  ./obs.nix
  
  ./printing-and-scanning.nix
  ];
}