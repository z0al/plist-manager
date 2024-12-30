{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    tapToClick = true;
    speed = 2;
  };

  test = ''
    has "write -g 'com.apple.trackpad.scaling' -int 2"
    has "write 'com.apple.AppleMultitouchTrackpad' 'Clicking' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Clicking' -bool 1"
  '';
}
