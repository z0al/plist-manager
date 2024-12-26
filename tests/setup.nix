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
      configuration =
        { config, ... }:
        {
          imports = [
            self.darwinModules.default
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
  desktop = makeTest ./desktop.nix;
  dock = makeTest ./dock.nix;
  finder = makeTest ./finder.nix;
  safari = makeTest ./safari.nix;
}
