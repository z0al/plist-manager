{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "auto";
    showScrollBar = "when-scrolling";
  };

  test = ''
    has "delete -g 'AppleInterfaceStyle'"
    has "write -g 'AppleInterfaceStyleSwitchesAutomatically' -bool 1"
    has "write -g 'AppleShowScrollBars' -string 'WhenScrolling'"
  '';
}
