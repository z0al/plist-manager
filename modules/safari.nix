{ config, lib, ... }:

let
  cfg = config.plist.safari;
in

{
  options.plist.safari = with lib; {
    devTools = {
      enable = mkOption {
        type = types.nullOr types.bool;
        description = ''
          Whether to enable the developer tools in Safari

          _Affects:_
          - "com.apple.Safari.SandboxBroker"."ShowDevelopMenu"
        '';
        default = null;
      };
    };
  };

  config.plist.out = {
    "com.apple.Safari.SandboxBroker" = {
      ShowDevelopMenu = cfg.devTools.enable;
    };
  };
}
