{ pkgs, inputs, ... }:

let
  makeOptionsDoc = configuration: filter: pkgs.nixosOptionsDoc {
    inherit (configuration) options;

    transformOptions = option: option // {
      visible = filter option;
    };
  };

  darwinSystem = (inputs.nix-darwin.lib.darwinSystem {
    inherit (pkgs) system;
    modules = [
      inputs.self.darwinModules.default
    ];
  });

  hasPrefix = prefix: (option:
    builtins.elemAt option.loc 0 == "defaults" &&
    builtins.elemAt option.loc 1 == prefix
  );
in

pkgs.stdenvNoCC.mkDerivation {
  name = "darwin-defaults-book";
  src = ./.;

  patchPhase = ''

  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
