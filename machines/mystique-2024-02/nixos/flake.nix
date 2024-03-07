{
  description = "hostname mystique";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixos-vfio = {
      url = "github:j-brn/nixos-vfio";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nixos-vfio }: {
    nixosConfigurations = {
      mystique = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-vfio.nixosModules.vfio
          ./configuration.nix 
        ];
      };
    };
  };
}
