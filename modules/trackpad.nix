{ config, pkgs, lib, ... }:

let
  cfg = config.plist.trackpad;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist mkCond;

  multiTouchOptions = {
    Clicking = cfg.tapToClick;

    Dragging = mkCond
      (cfg.draggingStyle != null &&
        cfg.draggingStyle != "three-fingers")
      true;

    DragLock = mkCond
      (cfg.draggingStyle == "double-tap-lock")
      true;

    TrackpadThreeFingerDrag = mkCond
      (cfg.draggingStyle == "three-fingers")
      true;
  };
in

{
  options.plist.trackpad = with lib; {
    tapToClick = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to enable tap to click

        _Affects:_
        - "com.apple.AppleMultitouchTrackpad"."Clicking"
        - "com.apple.driver.AppleBluetoothMultitouch.trackpad"."Clicking"
      '';
    };

    naturalScrolling = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to move the contents of a window in the same direction as your fingers

        _Affects:_
        - "NSGlobalDomain"."com.apple.swipescrolldirection"
      '';
    };

    draggingStyle = mkNullableOption {
      type = types.enum [
        "double-tap"
        "double-tap-lock"
        "three-fingers"
      ];

      description = ''
        Adjust the trackpad dragging style:

        - _Double Tap_: Double-tap an item to drag with lifting your fingers. Dragging continues if you briefly lift your fingers; otherwise, it stops.
        - _Double Tap Lock_: Double-tap an item to drag without lifting your fingers. Dragging continues even after you lift your fingers until you tap once again.
        - _Three Fingers_: Drag an item with three fingers. Dragging continues if you briefly lift your fingers; otherwise, it stops.

        _Affects:_
        - "com.apple.AppleMultitouchTrackpad"."DragLock"
        - "com.apple.AppleMultitouchTrackpad"."Dragging"
        - "com.apple.AppleMultitouchTrackpad"."TrackpadThreeFingerDrag"
        - "com.apple.driver.AppleBluetoothMultitouch.trackpad"."DragLock"
        - "com.apple.driver.AppleBluetoothMultitouch.trackpad"."Dragging"
        - "com.apple.driver.AppleBluetoothMultitouch.trackpad"."TrackpadThreeFingerDrag"
      '';
    };

    speed = mkNullableOption {
      type = types.numbers.between 0 3;
      description = ''
        Adjust the trackpad tracking speed

        _Affects:_
        - "NSGlobalDomain"."com.apple.trackpad.scaling"
      '';
    };
  };

  config.plist.out = writePlist {
    NSGlobalDomain = {
      "com.apple.trackpad.scaling" = cfg.speed;
      "com.apple.swipescrolldirection" = cfg.naturalScrolling;
    };

    "com.apple.AppleMultitouchTrackpad" = multiTouchOptions;
    "com.apple.driver.AppleBluetoothMultitouch.trackpad" = multiTouchOptions;
  };
}

