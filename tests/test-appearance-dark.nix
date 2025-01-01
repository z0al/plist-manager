{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "dark";
  };

  test = ''
    Domain NSGlobalDomain
    Set AppleInterfaceStyle '"Dark"'
    Del AppleInterfaceStyleSwitchesAutomatically
  '';
}
