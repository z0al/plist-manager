# plist-manager

<!-- MANUAL START -->

<!-- toc -->

## Introduction

Plist-manager (PM) is a Nix module for managing macOS user defaults. Unlike the built-in options offered by [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager), PM provides the following advantages:

- Human-friendly naming of domains and options, e.g., `trackpad.draggingStyle = "three-fingers"`.
- Automatic reloading of system settings with `activateSettings -u` after applying changes.
- Unsetting an option or explicitly setting it to `null` _resets_ its value, effectively performing a `defaults delete <domain> <option>` command.

The _null equals reset_ rule makes this module particularly useful, as it ensures that any option previously set is restored to the system default. This behavior is crucial for configurations that are conditionally set, e.g., `NSGlobalDomain.AppleInterfaceStyle`, which is removed if the user opts for Light or Auto appearance mode.

> [!IMPORTANT]
>
> Since all options provided by this module default to `null`, by adding the module to a Nix flake you risk losing some user defaults that are not managed with Nix.
>
> This also makes the module incompatible with the built-in alternatives from nix-darwin and home-manager (unless used to set values that aren't touched by plist-manager; see the _"Affects: ..."_ block next to each option in the [reference](https://z0al.github.io/plist-manager#reference) for more information about which plist keys are affected).
>
> In the near future, I plan to keep track of unset values properly and only delete those instead of every attribute.

## Installation

To get started, add `plist-manager` to your [Nix flake](https://nix.dev/concepts/flakes) inputs:

```nix
{
  inputs.plist-manager.url = "github:z0al/plist-manager";
  inputs.plist-manager.inputs.nixpkgs.follows = "nixpkgs";
}
```

This module provides integrations for both nix-darwin and home-manager. You can use either one, but NOT both, to avoid behavior conflicts.

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

See available options at https://z0al.github.io/plist-manager

## Development

### Local Environment

This repository provides a Nix shell to set up all the tools you need. You can integrate it with [direnv](https://github.com/nix-community/nix-direnv) by adding the following to your `.envrc`:

```sh
use_flake
```

### Running Unit Tests

All test files must be placed under `./tests` and prefixed with `test-*`. Tests are automatically imported. See [tests/setup.nix](./tests/setup.nix) for more details.

```sh
make test
```

### Serving Documentation Locally

```sh
make site
```

### Inspecting Plist Domains and Keys

This repository bundles [plistwatch](https://github.com/catilac/plistwatch), which is a handy tool for inspecting and identifying the associated plist domains and keys for various system settings.

```sh
make watch
```

## License

This project is licensed under the terms of the [MIT license](./LICENSE).
