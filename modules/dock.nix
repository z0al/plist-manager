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
      '';
    };

    size = mkNullableOption {
      type = types.int;
      description = ''
        Size of the dock icons
      '';
    };

    showRecentApps = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show recent applications in the Dock
      '';
    };

    autoHide = {
      enable = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to automatically hide and show the dock
        '';
      };

      delay = mkNullableOption {
        type = types.float;
        description = ''
          Sets the speed of the auto-hide delay
        '';
      };

      animationDelay = mkNullableOption {
        type = types.float;
        description = ''
          Sets the speed of the animation when hiding/showing the Dock
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
        '';
      };

      toApplicationIcon = mkNullableOption {
        type = types.bool;
        description = ''
          Whether to minimize windows to the application icon
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
