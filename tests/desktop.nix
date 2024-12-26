{ config, ... }:

let
  cfg = config.system.defaults.CustomUserPreferences."com.apple.finder";
in

{
  defaults.desktop = {
    showIcons = true;
    showHardDisks = true;
    showExternalDisks = true;
    showRemovableMedia = true;
    showConnectedServers = true;
    keepFoldersOnTop = true;
  };

  assertions = [
    {
      message = "expects icons to be shown in desktop";
      assertion = cfg.CreateDesktop == true;
    }

    {
      message = "expects hard disks to be shown in desktop";
      assertion = cfg.ShowHardDrivesOnDesktop == true;
    }

    {
      message = "expects external disks to be shown in desktop";
      assertion = cfg.ShowExternalHardDrivesOnDesktop == true;
    }

    {
      message = "expects removable media to be shown in desktop";
      assertion = cfg.ShowRemovableMediaOnDesktop == true;
    }

    {
      message = "expects connected servers to be shown in desktop";
      assertion = cfg.ShowMountedServersOnDesktop == true;
    }

    {
      message = "expects folders to be kept on top when sorting in desktop";
      assertion = cfg._FXSortFoldersFirstOnDesktop == true;
    }
  ];
}
