test:
	@nix flake check

site:
	@nix build .#docs
