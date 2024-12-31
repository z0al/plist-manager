{ config, pkgs, lib, ... }:

let
  cfg = config.plist.appearance;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption mkCond writePlist;
in

{
  options.plist.appearance = with lib; {
    theme = mkNullableOption {
      type = types.enum [
        "auto"
        "light"
        "dark"
      ];
      description = ''
        Choose the appearance for buttons, menus and windows.

        Note that `auto` won't switch the appearance until your device has been
        idle for at least a minute or if an app is preventing the display from
        sleeping, such as during media playback

        _Affects:_
        - "NSGlobalDomain"."AppleInterfaceStyle"
        - "NSGlobalDomain"."AppleInterfaceStyleSwitchesAutomatically"
      '';
    };

    showScrollBar = mkNullableOption {
      type = types.enum [
        "auto"
        "always"
        "when-scrolling"
      ];
      description = ''
        Control when the scroll bar is shown

        _Affects:_
        - "NSGlobalDomain"."AppleShowScrollBars"
      '';
    };
  };

  config.plist.out = writePlist {
    NSGlobalDomain = {
      AppleInterfaceStyle = mkCond (cfg.theme == "dark") "Dark";
      AppleInterfaceStyleSwitchesAutomatically =
        mkCond (cfg.theme == "auto") true;

      AppleShowScrollBars =
        if cfg.showScrollBar == "auto" then "Automatic"
        else if cfg.showScrollBar == "always" then "Always"
        else if cfg.showScrollBar == "when-scrolling" then "WhenScrolling"
        else null;
    };
  };
}
