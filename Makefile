test:
	@nix flake check --show-trace

site:
	@nix build .#docs
