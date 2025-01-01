{ config, lib, ... }:

let
  cfg = config.plist.finder;
in

{
  options.plist.finder = with lib; {
    showHidden = mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show hidden files in Finder

        _Affects:_
        - "com.apple.finder"."AppleShowAllFiles"
      '';
      default = null;
    };

    showExtensions = mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show file extensions in the Finder

        _Affects:_
        - "NSGlobalDomain"."AppleShowAllExtensions"
      '';
      default = null;
    };

    keepFoldersOnTop = mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to keep folders on top when sorting

        _Affects:_
        - "com.apple.finder"."_FXSortFoldersFirst"
      '';
      default = null;
    };
  };

  config.plist.out = {
    NSGlobalDomain = {
      AppleShowAllExtensions = cfg.showExtensions;
    };

    "com.apple.finder" = {
      AppleShowAllFiles = cfg.showHidden;
      _FXSortFoldersFirst = cfg.keepFoldersOnTop;
    };
  };
}
