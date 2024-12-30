{ config, pkgs, lib, ... }:

let
  cfg = config.plist.safari;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist;
in

{
  options.plist.safari = with lib; {
    devTools = {
      enable = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to enable the developer tools in Safari
        '';
      };
    };
  };

  config.plist.out = writePlist {
    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = cfg.devTools.enable;
    };
  };
}
