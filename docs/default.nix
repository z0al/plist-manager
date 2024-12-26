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

  desktop = makeOptionsDoc darwinSystem (hasPrefix "desktop");
  dock = makeOptionsDoc darwinSystem (hasPrefix "dock");
  finder = makeOptionsDoc darwinSystem (hasPrefix "finder");
  safari = makeOptionsDoc darwinSystem (hasPrefix "safari");
in

pkgs.stdenvNoCC.mkDerivation {
  name = "better-defaults-book";
  src = ./.;

  patchPhase = ''
    # The "declared by" links point to a file which only exists when the docs
    # are built locally. This removes the links.
    sed '/*Declared by:*/,/^$/d' <${desktop.optionsCommonMark} >>src/options/desktop.md
    sed '/*Declared by:*/,/^$/d' <${dock.optionsCommonMark} >>src/options/dock.md
    sed '/*Declared by:*/,/^$/d' <${finder.optionsCommonMark} >>src/options/finder.md
    sed '/*Declared by:*/,/^$/d' <${safari.optionsCommonMark} >>src/options/safari.md
  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
