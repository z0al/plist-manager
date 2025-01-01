{ config, lib, ... }:

let
  cfg = config.plist.dock;
in

{
  options.plist.dock = with lib; {
    position = mkOption {
      type = types.nullOr (
        types.enum [
          "bottom"
          "left"
          "right"
        ]);
      description = ''
        Position of the dock on screen

        _Affects:_
        - "com.apple.dock"."orientation"
      '';
      default = null;
    };

    size = mkOption {
      type = types.nullOr types.int;
      description = ''
        Size of the dock icons

        _Affects:_
        - "com.apple.dock"."tilesize"
      '';
      default = null;
    };

    showRecentApps = mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show recent applications in the Dock

        _Affects:_
        - "com.apple.dock"."show-recents"
      '';
      default = null;
    };

    autoHide = {
      enable = mkOption {
        type = types.nullOr types.bool;
        description = ''
          Whether to automatically hide and show the dock

          _Affects:_
          - "com.apple.dock"."autohide"
        '';
        default = null;
      };

      delay = mkOption {
        type = types.nullOr types.float;
        description = ''
          Sets the speed of the auto-hide delay

          _Affects:_
          - "com.apple.dock"."autohide-delay"
        '';
        default = null;
      };

      animationDelay = mkOption {
        type = types.nullOr types.float;
        description = ''
          Sets the speed of the animation when hiding/showing the Dock

          _Affects:_
          - "com.apple.dock"."autohide-time-modifier"
        '';
        default = null;
      };
    };

    minimize = {
      effect = mkOption {
        type = types.nullOr (
          types.enum [
            "genie"
            "scale"
            "suck"
          ]);
        description = ''
          Sets the effect of minimizing windows

          _Affects:_
          - "com.apple.dock"."mineffect"
        '';
        default = null;
      };

      toApplicationIcon = mkOption {
        type = types.nullOr types.bool;
        description = ''
          Whether to minimize windows to the application icon

          _Affects:_
          - "com.apple.dock"."minimize-to-application"
        '';
        default = null;
      };
    };
  };

  config.plist.out = {
    "com.apple.dock" = {
      orientation = cfg.position;
      tilesize = cfg.size;
      show-recents = cfg.showRecentApps;
      mineffect = cfg.minimize.effect;
      minimize-to-application = cfg.minimize.toApplicationIcon;

      # Auto hide
      autohide = cfg.autoHide.enable;
      autohide-delay =
        if cfg.autoHide.enable then
          cfg.autoHide.delay else null;
      autohide-time-modifier =
        if cfg.autoHide.enable then
          cfg.autoHide.animationDelay else null;
    };
  };
}
