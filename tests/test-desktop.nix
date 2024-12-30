{
  imports = [
    ../modules/desktop.nix
  ];

  defaults.desktop = {
    showIcons = true;
    showHardDisks = true;
    showExternalDisks = true;
    showRemovableMedia = true;
    showConnectedServers = true;
    keepFoldersOnTop = true;
  };

  test = ''
    has "write com.apple.finder 'CreateDesktop' -bool 1"
    has "write com.apple.finder 'ShowHardDrivesOnDesktop' -bool 1"
    has "write com.apple.finder 'ShowExternalHardDrivesOnDesktop' -bool 1"
    has "write com.apple.finder 'ShowRemovableMediaOnDesktop' -bool 1"
    has "write com.apple.finder '_FXSortFoldersFirstOnDesktop' -bool 1"
    has "write com.apple.finder 'ShowMountedServersOnDesktop' -bool 1"
  '';
}
