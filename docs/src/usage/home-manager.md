# Home Manager

1. Add `better-defaults` to your inputs

```nix
{
	inputs = {
		# ... other inputs
		better-defaults.url = "github:z0al/better-defaults.nix";
		better-defaults.inputs.nixpkgs.follows = "nixpkgs";
	};
}
```

2. Add `better-defaults.homeManagerModules.default` to your home-manager modules

```nix
{
	homeConfigurations = {
		userName = home-manager.lib.homeManagerConfiguration {
			modules = [
				# ... other modules
				better-defaults.homeManagerModules.default
			];
		};
	};
}
```
