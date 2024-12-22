{
  description = "Declarative macOS user defaults";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nix-darwin, ... }:
    let
      perSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      tests = perSystem (system: import ./tests/setup.nix {
        inherit nixpkgs system nix-darwin;
      });
    in

    {
      darwinModules.default = import ./targets/darwin.nix;
      homeManagerModules.default = import ./targets/home-manager.nix;

      checks = perSystem (system: tests.${system});
    };
}
