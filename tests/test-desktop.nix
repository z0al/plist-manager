{
  imports = [
    ../modules/desktop.nix
  ];

  plist.desktop = {
    showIcons = true;
    showHardDisks = true;
    showExternalDisks = true;
    showRemovableMedia = true;
    showConnectedServers = true;
    keepFoldersOnTop = null;
  };

  test = ''
    Domain com.apple.finder
    Set CreateDesktop true
    Set ShowHardDrivesOnDesktop true
    Set ShowExternalHardDrivesOnDesktop true
    Set ShowRemovableMediaOnDesktop true
    Set ShowMountedServersOnDesktop true

    Del _FXSortFoldersFirstOnDesktop
  '';
}
