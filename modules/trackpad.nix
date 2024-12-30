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

    draggingStyle = mkNullableOption {
      type = types.enum [
        "double-tap"
        "double-tap-lock"
        "three-fingers"
      ];

      description = ''
        Adjust the trackpad dragging style:

        - **Double Tap**: Double-tap an item, then drag it without lifting your finger after the second tap; when you lift your finger, the item stops moving.
        - **Double Tap Lock**: Double-tap an item, then drag it without lifting your finger after the second tap; dragging continues when you lift your finger, and stops when you tap the trackpad once.
        - **Three Fingers**: Drag an item with three fingers; dragging stops when you lift your fingers

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
    };

    "com.apple.AppleMultitouchTrackpad" = multiTouchOptions;
    "com.apple.driver.AppleBluetoothMultitouch.trackpad" = multiTouchOptions;
  };
}

