# Home Manager

1. Add `darwin-defaults` to your inputs

```nix
{
	inputs = {
		# ... other inputs
		darwin-defaults.url = "github:z0al/better-defaults.nix";
		darwin-defaults.inputs.nixpkgs.follows = "nixpkgs";
	};
}
```

2. Add `darwin-defaults.homeManagerModules.default` to your home-manager modules

```nix
{
	homeConfigurations = {
		userName = home-manager.lib.homeManagerConfiguration {
			modules = [
				# ... other modules
				darwin-defaults.homeManagerModules.default
			];
		};
	};
}
```
