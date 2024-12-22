{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nix-darwin, ... }:
    let
      perSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
      ];

      tests = perSystem (system: import ./tests/setup.nix {
        inherit nixpkgs system nix-darwin;
      });
    in

    {
      checks = perSystem (system: tests.${system});
    };
}
