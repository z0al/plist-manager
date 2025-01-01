{
  imports = [
    ../modules
  ];

  plist.desktop.showIcons = null;
  plist.dock.position = null;
  plist.finder.showHidden = null;
  plist.safari.devTools.enable = null;

  test = ''
    Domain NSGlobalDomain
    Del AppleShowAllExtensions

    Domain com.apple.finder
    Del CreateDesktop

    Domain com.apple.dock
    Del orientation

    Domain com.apple.Safari.SandboxBroker
    Del ShowDevelopMenu
  '';
}
