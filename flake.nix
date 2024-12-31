{
  description = "Nix-Based macOS User Defaults Done Right";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , flake-parts
    , ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = { pkgs, system, ... }:
        let
          tests = import ./tests/setup.nix {
            inherit pkgs inputs system;
          };

          docs = import ./docs {
            inherit pkgs inputs system;
          };
        in

        {
          checks = tests;

          legacyPackages = {
            inherit docs;
          };

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              plistwatch
              nodePackages.serve
            ];
          };
        };

      flake = {
        darwinModules.default = import ./targets/darwin.nix;
        homeManagerModules.default = import ./targets/home-manager.nix;
      };
    };
}
