{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "light";
  };

  test = ''
    Domain NSGlobalDomain
    Del AppleInterfaceStyle
    Del AppleInterfaceStyleSwitchesAutomatically
  '';
}
