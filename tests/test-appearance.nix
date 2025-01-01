{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "auto";
    showScrollBar = "when-scrolling";
  };

  test = ''
    Domain NSGlobalDomain
    Set AppleInterfaceStyleSwitchesAutomatically true
    Set AppleShowScrollBars '"WhenScrolling"'
    Del AppleInterfaceStyle
  '';
}
