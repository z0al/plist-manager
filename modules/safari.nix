{ config, pkgs, lib, ... }:

let
  cfg = config.defaults.safari;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writeDefaults;
in

{
  options.defaults.safari = with lib; {
    devTools = {
      enable = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to enable the developer tools in Safari
        '';
      };
    };
  };

  config.defaults.out = writeDefaults {
    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = cfg.devTools.enable;
    };
  };
}
