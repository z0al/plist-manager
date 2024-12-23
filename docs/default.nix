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

  dock = makeOptionsDoc darwinSystem (hasPrefix "dock");
  finder = makeOptionsDoc darwinSystem (hasPrefix "finder");
in

pkgs.stdenvNoCC.mkDerivation {
  name = "darwin-defaults-book";
  src = ./.;

  patchPhase = ''
    # The "declared by" links point to a file which only exists when the docs
    # are built locally. This removes the links.
    sed '/*Declared by:*/,/^$/d' <${dock.optionsCommonMark} >>src/options/dock.md
    sed '/*Declared by:*/,/^$/d' <${finder.optionsCommonMark} >>src/options/finder.md
  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
