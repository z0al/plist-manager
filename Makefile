test:
	@nix flake check --show-trace --option log-lines 1000

site:
	@nix build .#docs && serve ./result

watch:
	@plistwatch
