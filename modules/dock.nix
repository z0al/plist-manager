{ config, pkgs, lib, ... }:

let
  cfg = config.plist.dock;

  inherit (pkgs.callPackage ../lib { }) mkCond mkNullableOption writePlist;
in

{
  options.plist.dock = with lib; {
    position = mkNullableOption {
      type = types.enum [
        "bottom"
        "left"
        "right"
      ];
      description = ''
        Position of the dock on screen

        _Affects:_
        - "com.apple.dock"."orientation"
      '';
    };

    size = mkNullableOption {
      type = types.int;
      description = ''
        Size of the dock icons

        _Affects:_
        - "com.apple.dock"."tilesize"
      '';
    };

    showRecentApps = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show recent applications in the Dock

        _Affects:_
        - "com.apple.dock"."show-recents"
      '';
    };

    autoHide = {
      enable = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to automatically hide and show the dock

          _Affects:_
          - "com.apple.dock"."autohide"
        '';
      };

      delay = mkNullableOption {
        type = types.float;
        description = ''
          Sets the speed of the auto-hide delay

          _Affects:_
          - "com.apple.dock"."autohide-delay"
        '';
      };

      animationDelay = mkNullableOption {
        type = types.float;
        description = ''
          Sets the speed of the animation when hiding/showing the Dock

          _Affects:_
          - "com.apple.dock"."autohide-time-modifier"
        '';
      };
    };

    minimize = {
      effect = mkNullableOption {
        type = types.enum [
          "genie"
          "scale"
          "suck"
        ];
        description = ''
          Sets the effect of minimizing windows

          _Affects:_
          - "com.apple.dock"."mineffect"
        '';
      };

      toApplicationIcon = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to minimize windows to the application icon

          _Affects:_
          - "com.apple.dock"."minimize-to-application"
        '';
      };
    };
  };

  config.plist.out = writePlist {
    "com.apple.dock" = {
      orientation = cfg.position;
      tilesize = cfg.size;
      show-recents = cfg.showRecentApps;
      mineffect = cfg.minimize.effect;
      minimize-to-application = cfg.minimize.toApplicationIcon;

      # Auto hide
      autohide = cfg.autoHide.enable;
      autohide-delay = mkCond cfg.autoHide.enable cfg.autoHide.delay;
      autohide-time-modifier = mkCond
        cfg.autoHide.enable
        cfg.autoHide.animationDelay;
    };
  };
}
