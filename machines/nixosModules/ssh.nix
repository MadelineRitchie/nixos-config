{ pkgs, ... }:
{
  services = {
    openssh = {
      enable = true;
      allowSFTP = true;
    };
    
    # SSH daemon.
    sshd.enable = true;
  };
}