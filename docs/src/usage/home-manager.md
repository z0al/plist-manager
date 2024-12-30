# Home Manager

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

2. Add `plist-manager.homeManagerModules.default` to your home-manager modules

```nix
{
	homeConfigurations = {
		userName = home-manager.lib.homeManagerConfiguration {
			modules = [
				# ... other modules
				plist-manager.homeManagerModules.default
			];
		};
	};
}
```
