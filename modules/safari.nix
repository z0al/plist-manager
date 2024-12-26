{ config, pkgs, lib, ... }:

let
  cfg = config.defaults.safari;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption;
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

  config.defaults._impl = {
    "com.apple.Safari" = {
      WebKitDeveloperExtrasEnabledPreferenceKey = cfg.devTools.enable;
      "WebKitPreferences.developerExtrasEnabled" = cfg.devTools.enable;
    };

    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = cfg.devTools.enable;
    };
  };
}
