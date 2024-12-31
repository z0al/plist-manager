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
    keepFoldersOnTop = true;
  };

  test = ''
    has "write 'com.apple.finder' 'CreateDesktop' -bool true"
    has "write 'com.apple.finder' 'ShowHardDrivesOnDesktop' -bool true"
    has "write 'com.apple.finder' 'ShowExternalHardDrivesOnDesktop' -bool true"
    has "write 'com.apple.finder' 'ShowRemovableMediaOnDesktop' -bool true"
    has "write 'com.apple.finder' '_FXSortFoldersFirstOnDesktop' -bool true"
    has "write 'com.apple.finder' 'ShowMountedServersOnDesktop' -bool true"
  '';
}
