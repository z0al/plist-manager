{ config, lib, ... }:

let
  cfg = config.defaults.dock;
in

{
  options.defaults.dock = with lib; {
    position = mkOption {
      type = types.nullOr (types.enum [
        "bottom"
        "left"
        "right"
      ]);
      description = ''
        Position of the dock on screen
      '';
      default = null;
    };

    autoHide = {
      enable = mkOption {
        type = types.nullOr types.bool;
        description = ''
          Whether to automatically hide and show the dock
        '';
        default = null;
      };

      delay = mkOption {
        type = types.nullOr types.float;
        description = ''
          Sets the speed of the auto-hide delay
        '';
        default = null;
      };

      animationDelay = mkOption {
        type = types.nullOr types.float;
        description = ''
          Sets the speed of the animation when hiding/showing the Dock
        '';
        default = null;
      };
    };
  };

  config.defaults._impl = {
    "com.apple.dock" = {
      # Position
      orientation = cfg.position;

      # Auto hide
      autohide = cfg.autoHide.enable;
      autohide-delay =
        if cfg.autoHide.enable
        then cfg.autoHide.delay else null;
      autohide-time-modifier =
        if cfg.autoHide.enable
        then cfg.autoHide.animationDelay else null;
    };
  };
}
