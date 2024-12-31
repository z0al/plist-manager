# Plist Manager

<!-- MANUAL START -->

<!-- toc -->

## Introduction

Plist Manager (PM) is a Nix module for managing macOS user defaults. Unlike the built-in `defaults.*` modules offered by [nix-darwin] and [home-manager], PM provides the following advantages:

- Human-friendly naming of domains and options, e.g., `trackpad.draggingStyle = "three-fingers"`.
- Automatically reloads system settings with `activateSettings -u` after applying changes.
- Unsetting an option or explicitly setting it to `null` _resets_ its value, effectively performing a `defaults delete <domain> <option>` command.

The _null equals reset_ rule makes this module particularly useful, as it ensures that an option previously set is restored to the system default.

This feature is crucial for configurations that are conditionally set, e.g., `NSGlobalDomain.AppleInterfaceStyle`, which is removed if the user opts for Light or Auto appearance mode.

The rule also enforces that all configuration adjustments be applied via Nix; otherwise, you risk losing your changes during every nix-darwin system activation. Currently, this applies only to the configurations supported by the module. As the module expands, the likelihood of losing changes done outside Nix increases, so ensure you regularly apply the configurations you care about using Nix.

While this might sound intimidating, in practice, reverting to device defaults is usually fine and makes reasoning about how the module works much easier.

## Installation

To get started, add `plist-manager` to your [Nix flake](https://nix.dev/concepts/flakes) inputs:

```nix
{
  inputs.plist-manager.url = "github:z0al/plist-manager";
  inputs.plist-manager.inputs.nixpkgs.follows = "nixpkgs";
}
```

Plist Manager provides Nix modules for both [nix-darwin] and [home-manager]. You should use either one, but NOT both, to avoid behavior conflicts.

### For nix-darwin users

Add `plist-manager.darwinModules.default` to your nix-darwin modules:

```nix
{
	darwinConfigurations.hostname = darwin.lib.darwinSystem {
    modules = [
      # ... other modules
      plist-manager.darwinModules.default
    ];
  };
}
```

### For home-manager users

Add `plist-manager.homeManagerModules.default` to your home-manager modules:

```nix
{
	homeConfigurations.userName = home-manager.lib.homeManagerConfiguration {
    modules = [
      # ... other modules
      plist-manager.homeManagerModules.default
    ];
  };
}
```

<!-- MANUAL END -->

## Documentation

See installation instructions and available options at https://z0al.github.io/plist-manager

## License

This project is licensed under the terms of the [MIT license](./LICENSE).

[nix-darwin]: https://github.com/LnL7/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
