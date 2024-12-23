{ config, pkgs, lib, ... }:

let
  cfg = config.defaults.dock;

  inherit (pkgs.callPackage ../lib { })
    mkCond
    mkNullableOption;
in

{
  options.defaults.dock = with lib; {
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
  };

  config.defaults._impl."com.apple.dock" = {
    # Position
    orientation = cfg.position;

    # Auto hide
    autohide = cfg.autoHide.enable;
    autohide-delay = mkCond cfg.autoHide.enable cfg.autoHide.delay;
    autohide-time-modifier = mkCond
      cfg.autoHide.enable
      cfg.autoHide.animationDelay;
  };
}
