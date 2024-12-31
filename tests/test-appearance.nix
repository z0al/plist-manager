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
    has "write -g 'AppleInterfaceStyleSwitchesAutomatically' -bool true"
    has "write -g 'AppleShowScrollBars' -string 'WhenScrolling'"
  '';
}
