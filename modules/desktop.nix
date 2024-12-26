{ config, pkgs, lib, ... }:

let
  cfg = config.defaults.desktop;

  inherit (pkgs.callPackage ../lib { }) mkNullableOption;
in

{
  options.defaults.desktop = with lib; {
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
  };

  config.defaults._impl."com.apple.finder" = {
    CreateDesktop = cfg.showIcons;
    ShowHardDrivesOnDesktop = cfg.showHardDisks;
    ShowExternalHardDrivesOnDesktop = cfg.showExternalDisks;
    ShowRemovableMediaOnDesktop = cfg.showRemovableMedia;
    ShowMountedServersOnDesktop = cfg.showConnectedServers;
  };
}
