{ pkgs, inputs, lib ? pkgs.lib, ... }:

let
  githubLink = subpath:
    let
      user = "z0al";
      repo = "plist-manager";
    in
    {
      url = "https://github.com/${user}/${repo}/blob/main/${subpath}";
      name = "<${subpath}>";
    };

  makeOptionsDoc = configuration: filter: pkgs.nixosOptionsDoc {
    inherit (configuration) options;

    transformOptions = option: option // {
      visible = filter option;
      declarations = map
        (decl:
          githubLink
            (lib.removePrefix "/"
              (lib.removePrefix (toString ./..) (toString decl))))
        option.declarations;
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
  name = "plist-manager-book";
  src = ./.;

  patchPhase = ''
    cat ${desktop.optionsCommonMark} >>src/options/desktop.md
    cat ${dock.optionsCommonMark} >>src/options/dock.md
    cat ${finder.optionsCommonMark} >>src/options/finder.md
    cat ${safari.optionsCommonMark} >>src/options/safari.md
  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
