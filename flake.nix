{
  description = "larp";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nix-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        inputs.spicetify-nix.homeManagerModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kletus = import ./home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
      extraSpecialArgs = { inherit inputs; };
    };
  };

}
