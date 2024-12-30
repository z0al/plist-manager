{ config, pkgs, lib, ... }:

let
  cfg = config.plist.desktop;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption writePlist;
in

{
  options.plist.desktop = with lib; {
    showIcons = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show icons on the desktop
      '';
    };

    showHardDisks = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show hard disks on the desktop
      '';
    };

    showExternalDisks = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show external disks on the desktop
      '';
    };

    showRemovableMedia = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show removable media (CDs, DVDs and iPods) on the desktop
      '';
    };

    showConnectedServers = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to show connected servers on the desktop
      '';
    };

    keepFoldersOnTop = mkNullableOption {
      type = types.bool;
      description = ''
        Whether to keep folders on top when sorting
      '';
    };
  };

  config.plist.out = writePlist {
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
