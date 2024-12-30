# Nix Darwin

1. Add `plist-manager` to your inputs

```nix
{
	inputs = {
		# ... other inputs
		plist-manager.url = "github:z0al/plist-manager";
		plist-manager.inputs.nixpkgs.follows = "nixpkgs";
	};
}
```

2. Add `plist-manager.darwinModules.default` to your nix-darwin modules

```nix
{
	darwinConfigurations = {
		hostname = darwin.lib.darwinSystem {
			modules = [
				# ... other modules
				plist-manager.darwinModules.default
			];
		};
	};
}
```
