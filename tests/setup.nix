{ self
, nixpkgs
, nix-darwin
, system
}:

let
  buildFromConfig = configuration: sel: sel
    (import nix-darwin { inherit nixpkgs configuration system; }).config;

  makeTest = test:
    let
      testName =
        builtins.replaceStrings [ ".nix" ] [ "" ]
          (builtins.baseNameOf test);

      configuration =
        { config, pkgs, lib, ... }:
        {
          imports = [
            self.darwinModules.default
            test
          ];

          options.test = lib.mkOption {
            type = lib.types.lines;
            default = "";
          };

          config = {
            system.stateVersion = config.system.maxStateVersion;

            system.build.run-test = pkgs.runCommandLocal "test-${testName}"
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

                echo "Running '${testName}' tests"
                ${config.test}
              '';
          };
        };
    in
    buildFromConfig configuration (config: config.system.build.run-test);
in

{
  desktop = makeTest ./desktop.nix;
  dock = makeTest ./dock.nix;
  finder = makeTest ./finder.nix;
  safari = makeTest ./safari.nix;
}
