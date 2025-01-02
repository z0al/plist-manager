{ self
, pkgs
, inputs
, system
}:

with pkgs.lib;

let
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
        { config, pkgs, ... }:

        let
          defaults = builtins.toJSON
            config.system.defaults.CustomUserPreferences;

          purgeScript = config.plist.purgeScript;
        in

        {
          imports = [
            self.darwinModules.default
            test
          ];

          options.test = mkOption {
            type = types.lines;
          };

          config = {
            system.stateVersion = config.system.maxStateVersion;

            system.build.run-test = pkgs.runCommandLocal name
              {
                nativeBuildInputs = with pkgs; [
                  jq
                ];
              }
              ''
                set -e
                mkdir -p $out
                echo ${escapeShellArg defaults} > $out/defaults.json
                echo ${escapeShellArg purgeScript} > $out/purge.sh

                # Holds domain context
                d=""

                function Domain {
                  if [[ -n "$d" ]]; then
                    echo "Domain end"
                  fi

                  d=$1

                  echo ""
                  echo "Domain start: '$d'"
                }

                function Set {
                  v=$(cat $out/defaults.json | jq ".\"$d\".\"$1\"")

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
                    jq . $out/defaults.json | sed 's/^/    /'
                    echo ""
                    exit 1
                  fi
                }

                function Del {
                  if ! grep -q "defaults delete '$d' '$1'" $out/purge.sh; then
                    echo ""
                    echo "Expected attribute '$d'.'$1' to be deleted."
                    echo ""
                    echo "Actual output:"
                    echo ""
                    cat $out/purge.sh | sed 's/^/    /'
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

listToAttrs (map
  (file: rec {
    name = testName file;
    value = makeTest name file;
  })
  (fileset.toList
    (fileset.fileFilter (file: hasPrefix "test-" file.name) ./.)))
