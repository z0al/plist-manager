{ config, pkgs, lib, ... }:

let
  cfg = config.plist.finder;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist;
in

{
  options.plist.finder = with lib; {
    showHidden = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show hidden files in Finder

        _Affects:_
        - "com.apple.finder".AppleShowAllFiles
      '';
    };

    showExtensions = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show file extensions in the Finder

        _Affects:_
        - NSGlobalDomain.AppleShowAllExtensions
      '';
    };

    keepFoldersOnTop = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to keep folders on top when sorting

        _Affects:_
        - "com.apple.finder"._FXSortFoldersFirst
      '';
    };
  };

  config.plist.out = writePlist {
    NSGlobalDomain = {
      AppleShowAllExtensions = cfg.showExtensions;
    };

    "com.apple.finder" = {
      AppleShowAllFiles = cfg.showHidden;
      _FXSortFoldersFirst = cfg.keepFoldersOnTop;
    };
  };
}
