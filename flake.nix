{
  description = "NixOS configuration";

  inputs = {
    # NIX
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Musnix
    musnix  = { url = "github:musnix/musnix"; };

    # NUR
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Auto-Cpufreq
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let 
    system = "x86_64-linux";      
  in
  {
    nixosConfigurations = {

      personal = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };

        modules = [
          inputs.auto-cpufreq.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.musnix.nixosModules.musnix

          ./hosts/personal/configuration.nix
        ];
      };

    };
  };
}
