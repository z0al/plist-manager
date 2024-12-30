{ pkgs
, inputs
, system
}:

let
  lib = pkgs.lib;

  buildFromConfig = configuration: sel: sel
    (import inputs.nix-darwin {
      inherit (inputs) nixpkgs;
      inherit configuration system;
    }).config;

  testName = file:
    builtins.replaceStrings [ ".nix" ] [ "" ]
      (builtins.baseNameOf file);

  makeTest = name: test:
    let
      configuration =
        { config, pkgs, lib, ... }:
        {
          imports = [
            ../modules/impl
            test
          ];

          options.test = lib.mkOption {
            type = lib.types.lines;
          };

          config = {
            system.stateVersion = config.system.maxStateVersion;

            system.build.run-test = pkgs.runCommandLocal name
              { }
              ''
                set -e
                echo ${lib.escapeShellArg config.defaults.out} > $out

                function has {
                  if ! grep -q "$1" $out; then
                    echo ""
                    echo "Expected output to contain:"
                    echo ""
                    echo "    $1"
                    echo ""
                    echo "Actual output:"
                    echo ""
                    cat $out | sed 's/^/    /'
                    echo ""
                    exit 1
                  fi
                }

                echo "Running '${name}'"
                ${config.test}
              '';
          };
        };
    in
    buildFromConfig configuration (config: config.system.build.run-test);
in

lib.listToAttrs (map
  (file: rec {
    name = testName file;
    value = makeTest name file;
  })
  (lib.fileset.toList
    (lib.fileset.fileFilter (file: lib.hasPrefix "test-" file.name) ./.)))
