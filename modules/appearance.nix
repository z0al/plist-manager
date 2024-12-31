{ config, pkgs, lib, ... }:

let
  cfg = config.plist.appearance;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist;
in

{
  options.plist.appearance = with lib; {
    showScrollBar = mkNullableOption {
      type = types.enum [
        "auto"
        "always"
        "when-scrolling"
      ];
      description = ''
        Control when the scroll bar is shown
      '';
    };
  };

  config.plist.out = writePlist {
    NSGlobalDomain = {
      AppleShowScrollBars =
        if cfg.showScrollBar == "auto" then "Automatic"
        else if cfg.showScrollBar == "always" then "Always"
        else if cfg.showScrollBar == "when-scrolling" then "WhenScrolling"
        else null;
    };
  };
}
