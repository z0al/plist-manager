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

  optionsWithPrefix = prefix: (option:
    builtins.elemAt option.loc 0 == "plist" &&
    builtins.elemAt option.loc 1 == prefix
  );

  # Keep this list sorted alphabetically
  headers = [
    "Desktop"
    "Dock"
    "Finder"
    "Safari"
    "Trackpad"
  ];

  referenceSections = map
    (name:
      {
        title = name;
        file = (
          makeOptionsDoc darwinSystem (optionsWithPrefix (lib.toLower name))
        ).optionsCommonMark;
      })
    headers;
in

pkgs.stdenvNoCC.mkDerivation {
  name = "plist-manager-book";
  src = ./.;

  buildInputs = with pkgs; [
    mdbook
    mdbook-toc
  ];

  patchPhase = ''
    # Copy the introduction from the README
    sed -n '/^<!-- MANUAL START -->/,/^<!-- MANUAL END -->/p' \
      ${../README.md} >> src/index.md

    # Prefix table content with header
    sed -i -e 's/<!-- toc -->/**Table Of Contents**\n<!-- toc -->/g' \
      src/index.md

    # Add reference sections
    printf "\n## Reference\n\n" >> src/index.md
    ${lib.concatLines(
      map (section: ''
        printf "\n### ${section.title}\n\n" >> src/index.md

        # Force headers to be level 4
        sed -e 's/##/####/g' <${section.file} >> src/index.md
      '')
      referenceSections)}
  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}
