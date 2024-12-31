{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "light";
  };

  test = ''
    has "delete -g 'AppleInterfaceStyle'"
    has "delete -g 'AppleInterfaceStyleSwitchesAutomatically'"
  '';
}
