{
  description = "hostname mystique";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixos-vfio = {
      # url = "github:j-brn/nixos-vfio/c1b08dd51bcedf4bc31d105497ed26d34ed98902";
      url = "github:MadelineRitchie/nixos-vfio/mystique";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nixos-vfio }: {
    nixosConfigurations = {
      mystique = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-vfio.nixosModules.vfio
          ./machines/mystique/configuration.nix 
          ./machines/mystique/virtualisation.nix
        ];
      };
    };
  };
}
