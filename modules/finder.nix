{ config, pkgs, lib, ... }:

let
  cfg = config.defaults.finder;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption;
in

{
  options.defaults.finder = with lib; {
    showHidden = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show hidden files in Finder
      '';
    };

    showExtensions = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show file extensions in the Finder
      '';
    };

    keepFoldersOnTop = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to keep folders on top when sorting
      '';
    };
  };

  config.defaults._impl = {
    NSGlobalDomain = {
      AppleShowAllExtensions = cfg.showExtensions;
    };

    "com.apple.finder" = {
      AppleShowAllFiles = cfg.showHidden;
      _FXSortFoldersFirst = cfg.keepFoldersOnTop;
    };
  };
}
