{
  imports = [
    ../modules
  ];

  plist.desktop.showIcons = null;
  plist.dock.position = null;
  plist.finder.showHidden = null;
  plist.safari.devTools.enable = null;

  test = ''
    has "defaults delete 'com.apple.finder' 'CreateDesktop'"
    has "defaults delete 'com.apple.dock' 'orientation'"
    has "defaults delete -g 'AppleShowAllExtensions'"
    has "defaults delete 'com.apple.Safari.SandboxBroker' 'ShowDevelopMenu'"
  '';
}
