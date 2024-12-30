{
  imports = [
    ../modules
  ];

  defaults.desktop.showIcons = null;
  defaults.dock.position = null;
  defaults.finder.showHidden = null;
  defaults.safari.devTools.enable = null;

  test = ''
    has "defaults delete com.apple.finder 'CreateDesktop'"
    has "defaults delete com.apple.dock 'orientation'"
    has "defaults delete -g 'AppleShowAllExtensions'"
    has "defaults delete com.apple.Safari.SandboxBroker 'ShowDevelopMenu'"
  '';
}
