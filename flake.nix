{
  description = "Your new nix config";

  inputs = {
	  # Nixpkgs
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	  # MacOS stuff
	  nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

	  # Home manager
	  home-manager.url = "github:nix-community/home-manager/master";
	  home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

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
      sops-nix,
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
          sops-nix.nixosModules.sops 
		    ];
		  };
		  cappuccino = nixpkgs.lib.nixosSystem {
		    specialArgs = {inherit inputs outputs;};
		    modules = [
		      ./hosts/cappuccino/configuration.nix
		      home-manager.nixosModules.home-manager
		      {
		        # home-manager.useGlobalPkgs = true;
			      # home-manager.useUserPackages = true;
			      home-manager.users.alex = import ./users/alex/home.nix;
            home-manager.users.albert = import ./users/albert/home.nix;
            home-manager.users.matt = import ./users/matt/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass
			      # arguments to home.nix
	        }
          sops-nix.nixosModules.sops 
		    ];
		  };
	  };

	  darwinConfigurations = {
		  beetlejuice = nix-darwin.lib.darwinSystem {
		      specialArgs = {inherit inputs outputs;};
		    system = "aarch64-darwin";
		      modules = [
			  ./hosts/beetlejuice/darwin-configuration.nix
			  home-manager.darwinModules.home-manager
			  {
			      # home-manager configuration specific to macOS
			      home-manager.users.alex = import ./users/alex/home.nix;
			  }
		      ];
		  };
	  };
	};
}
