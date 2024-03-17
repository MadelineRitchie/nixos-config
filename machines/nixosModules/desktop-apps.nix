{ pkgs, ...}:
{
  programs = {
    partition-manager.enable = true;
    
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "madeline" ];
    };

    firefox.enable = true;
  };
}