{
  description = "Declarative darwin user defaults";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixpkgs
    , nix-darwin
    , flake-parts
    , ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = { system, ... }:
        let
          tests = import ./tests/setup.nix {
            inherit nixpkgs system nix-darwin;
          };
        in

        {
          checks = tests;
        };

      flake = {
        darwinModules.default = import ./targets/darwin.nix;
        homeManagerModules.default = import ./targets/home-manager.nix;
      };
    };
}
