{ nixpkgs
, nix-darwin
, system
}:

let
  buildFromConfig = configuration: sel: sel
    (import nix-darwin { inherit nixpkgs configuration system; }).config;

  makeTest = test:
    let
      configuration =
        { config, ... }:
        {
          imports = [
            ../targets/darwin.nix
            test
          ];

          config = {
            system.stateVersion = config.system.maxStateVersion;
          };
        };
    in
    buildFromConfig configuration (config: config.system.build.toplevel);
in

{
  sample = makeTest ./sample.nix;
}
