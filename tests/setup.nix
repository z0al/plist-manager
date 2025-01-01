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
            ../modules/_impl.nix
            test
          ];

          options.test = lib.mkOption {
            type = lib.types.lines;
          };

          config = {
            system.stateVersion = config.system.maxStateVersion;

            system.build.run-test = pkgs.runCommandLocal name
              {
                nativeBuildInputs = with pkgs; [
                  jq
                  jc
                  ripgrep
                ];
              }
              ''
                set -e
                echo ${lib.escapeShellArg config.plist.out} > $out

                # Holds domain context
                d=""

                # Holds path to the plist file for the domain (if any)
                f=""

                function Domain {
                  if [[ -n "$d" ]]; then
                    echo "Domain end"
                  fi

                  d=$1

                  echo ""
                  echo "Domain start: '$d'"

                  f=$(rg -PNo "'$d' (/nix/.*plist)" $out -r '$1' || echo None)
                  echo "Imports -> $f"
                }

                function Set {
                  if ! test -e "$f"; then
                    echo ""
                    echo "Assertion failed for '$1'. No imports to domain '$d'"
                    echo ""
                    exit 1
                  fi

                  v=$(cat $f | jc --plist | jq ".\"$1\"")

                  if [[ "$v" != "$2" ]]; then
                    echo ""
                    echo "Expected attribute '$d'.'$1' to equal:"
                    echo ""
                    echo "    $2"
                    echo ""
                    echo "But value is:"
                    echo ""
                    echo "    $v"
                    echo ""
                    echo "Full output:"
                    echo ""
                    cat $out | sed 's/^/    /'
                    echo ""
                    exit 1
                  fi
                }

                function Del {
                  if ! grep -q "defaults delete '$d' '$1'" $out; then
                    echo ""
                    echo "Expected attribute '$d'.'$1' to be deleted."
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
