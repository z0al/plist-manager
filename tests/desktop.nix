{ config, ... }:

let
  pref = config.system.defaults.CustomUserPreferences;
in

{
  defaults.desktop = {
    showIcons = true;
    showHardDisks = true;
    showExternalDisks = true;
    showRemovableMedia = true;
    showConnectedServers = true;
  };

  assertions = [
    {
      message = "expects icons to be shown in desktop";
      assertion = pref."com.apple.finder".CreateDesktop == true;
    }

    {
      message = "expects hard disks to be shown in desktop";
      assertion = pref."com.apple.finder".ShowHardDrivesOnDesktop == true;
    }

    {
      message = "expects external disks to be shown in desktop";
      assertion = pref."com.apple.finder".ShowExternalHardDrivesOnDesktop == true;
    }

    {
      message = "expects removable media to be shown in desktop";
      assertion = pref."com.apple.finder".ShowRemovableMediaOnDesktop == true;
    }

    {
      message = "expects connected servers to be shown in desktop";
      assertion = pref."com.apple.finder".ShowMountedServersOnDesktop == true;
    }
  ];
}
