{ config, lib, ... }:

let
  cfg = config.plist.appearance;
in

{
  options.plist.appearance = with lib; {
    theme = mkOption {
      type = types.nullOr (
        types.enum [
          "auto"
          "light"
          "dark"
        ]);
      description = ''
        Choose the appearance for buttons, menus and windows.

        Note that `auto` won't switch the appearance until your device has been
        idle for at least a minute or if an app is preventing the display from
        sleeping, such as during media playback

        _Affects:_
        - "NSGlobalDomain"."AppleInterfaceStyle"
        - "NSGlobalDomain"."AppleInterfaceStyleSwitchesAutomatically"
      '';
      default = null;
    };

    showScrollBar = mkOption {
      type = types.nullOr (
        types.enum [
          "auto"
          "always"
          "when-scrolling"
        ]);
      description = ''
        Control when the scroll bar is shown

        _Affects:_
        - "NSGlobalDomain"."AppleShowScrollBars"
      '';
      default = null;
    };
  };

  config.plist.out = {
    NSGlobalDomain = {
      AppleInterfaceStyle =
        if (cfg.theme == "dark") then "Dark" else null;
      AppleInterfaceStyleSwitchesAutomatically =
        if (cfg.theme == "auto") then true else null;

      AppleShowScrollBars =
        if cfg.showScrollBar == "auto" then "Automatic"
        else if cfg.showScrollBar == "always" then "Always"
        else if cfg.showScrollBar == "when-scrolling" then "WhenScrolling"
        else null;
    };
  };
}
