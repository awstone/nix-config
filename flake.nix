{
  description = "Your new nix config";

  inputs = {
	  # Nixpkgs
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

	  # MacOS stuff
	  nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

	  # Home manager
	  home-manager.url = "github:nix-community/home-manager/release-23.05";
	  home-manager.inputs.nixpkgs.follows = "nixpkgs";

	  # TODO: Add any other flake you might need
	  # hardware.url = "github:nixos/nixos-hardware";

	  # Shameless plug: looking for a way to nixify your themes and make
	  # everything match nicely? Try nix-colors!
	  # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
	  self,
	    nixpkgs,
	    nix-darwin,
	    home-manager,
	    ...
  } @ inputs: let
    inherit (self) outputs;
	in {  

	  # NixOS configuration entrypoint
	  # Available through 'nixos-rebuild --flake .#your-hostname'
	  nixosConfigurations = {
		  rickybobby = nixpkgs.lib.nixosSystem {
		    specialArgs = {inherit inputs outputs;};
		    modules = [
		      ./hosts/rickybobby/configuration.nix
		      home-manager.nixosModules.home-manager
		      {
		        # home-manager.useGlobalPkgs = true;
			      # home-manager.useUserPackages = true;
			      home-manager.users.alex = import ./users/alex/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
			      # arguments to home.nix
	        }
		    ];
		  };
		  cappuccino = nixpkgs.lib.nixosSystem {
		    specialArgs = {inherit inputs outputs;};
		    modules = [./hosts/cappuccino/configuration.nix];
		  };
	  };

	  darwinConfigurations = {
		  beetlejuice = nix-darwin.lib.darwinSystem {
		    inherit inputs;
		    system = "aarch64-darwin";
		    modules = [./hosts/beetlejuice/configuration.nix];
		  };
	  };
	};
}
