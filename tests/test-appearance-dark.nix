{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    theme = "dark";
  };

  test = ''
    has "write -g 'AppleInterfaceStyle' -string 'Dark'"
    has "delete -g 'AppleInterfaceStyleSwitchesAutomatically'"
  '';
}
