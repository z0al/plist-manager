# Nix Darwin

1. Add `better-defaults` to your inputs

```nix
{
	inputs = {
		# ... other inputs
		better-defaults.url = "github:z0al/better-defaults.nix";
		better-defaults.inputs.nixpkgs.follows = "nixpkgs";
		better-defaults.inputs.nix-darwin.follows = "nix-darwin";
	};
}
```

2. Add `better-defaults.darwinModules.default` to your nix-darwin modules

```nix
{
	darwinConfigurations = {
		hostname = darwin.lib.darwinSystem {
			modules = [
				# ... other modules
				better-defaults.darwinModules.default
			];
		};
	};
}
```
