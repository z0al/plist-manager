# Property List Manager (aka PM)

A Nix module for managing macOS user defaults. Unlike the built-in `defaults.*` modules offered by [nix-darwin] and [home-manager], PM provides the following advantages:

- Human-friendly naming of domains and options, e.g., `safari.devTools.enable`.
- Unsetting an option or explicitly setting it to `null` _resets_ its value, effectively performing a `defaults delete <domain> <option>` command.

The _null equals reset_ rule is what makes this module particularly useful, as it ensures that an option previously set gets restored to the system default.

This feature is crucial for configurations that are conditionally set, e.g., `NSGlobalDomain.AppleInterfaceStyle`, which gets removed if the user opts for Light or Auto appearance mode. At the time of writing, it is not possible to [unset a configuration value with the native nix-darwin module](https://github.com/LnL7/nix-darwin/issues/88).

The rule also enforces that all configuration adjustments be applied via Nix; otherwise, you risk losing your changes during every nix-darwin system activation. Currently, this only applies to the configurations supported by the module. As the module expands, the likelihood of losing unsaved changes increases, so ensure you regularly apply the configurations you care about using PM.

## Documentation

See installation instructions and available options at https://z0al.github.io/plist-manager

## License

This project is licensed under the terms of the [MIT license](./LICENSE).

[nix-darwin]: https://github.com/LnL7/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
