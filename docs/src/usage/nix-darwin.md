# Nix Darwin

1. Add `darwin-defaults` to your inputs

```nix
{
	inputs = {
		# ... other inputs
		darwin-defaults.url = "github:z0al/better-defaults.nix";
		darwin-defaults.inputs.nixpkgs.follows = "nixpkgs";
		darwin-defaults.inputs.nix-darwin.follows = "nix-darwin";
	};
}
```

2. Add `darwin-defaults.darwinModules.default` to your nix-darwin modules

```nix
{
	darwinConfigurations = {
		hostname = darwin.lib.darwinSystem {
			modules = [
				# ... other modules
				darwin-defaults.darwinModules.default
			];
		};
	};
}
```
