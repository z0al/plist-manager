{ config, lib, ... }:

let
  cfg = config.plist.desktop;
in

{
  options.plist.desktop = with lib; {
    showIcons = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show icons on the desktop

        _Affects:_
        - "com.apple.finder"."CreateDesktop"
      '';
      default = null;
    };

    showHardDisks = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show hard disks on the desktop

        _Affects:_
        - "com.apple.finder"."ShowHardDrivesOnDesktop"
      '';
      default = null;
    };

    showExternalDisks = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show external disks on the desktop

        _Affects:_
        - "com.apple.finder"."ShowExternalHardDrivesOnDesktop"
      '';
      default = null;
    };

    showRemovableMedia = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show removable media (CDs, DVDs and iPods) on the desktop

        _Affects:_
        - "com.apple.finder"."ShowRemovableMediaOnDesktop"
      '';
      default = null;
    };

    showConnectedServers = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to show connected servers on the desktop

        _Affects:_
        - "com.apple.finder"."ShowMountedServersOnDesktop"
      '';
      default = null;
    };

    keepFoldersOnTop = lib.mkOption {
      type = types.nullOr types.bool;
      description = ''
        Whether to keep folders on top when sorting

        _Affects:_
        - "com.apple.finder"."_FXSortFoldersFirstOnDesktop"
      '';
      default = null;
    };
  };

  config.plist.out = {
    "com.apple.finder" = {
      CreateDesktop = cfg.showIcons;
      ShowHardDrivesOnDesktop = cfg.showHardDisks;
      ShowExternalHardDrivesOnDesktop = cfg.showExternalDisks;
      ShowRemovableMediaOnDesktop = cfg.showRemovableMedia;
      ShowMountedServersOnDesktop = cfg.showConnectedServers;
      _FXSortFoldersFirstOnDesktop = cfg.keepFoldersOnTop;
    };
  };
}
