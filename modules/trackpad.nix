{ config, pkgs, lib, ... }:

let
  cfg = config.plist.trackpad;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist;
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

    "com.apple.AppleMultitouchTrackpad" = {
      Clicking = cfg.tapToClick;
    };

    "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
      Clicking = cfg.tapToClick;
    };
  };
}

