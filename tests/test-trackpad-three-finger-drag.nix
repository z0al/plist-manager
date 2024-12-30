{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    draggingStyle = "three-fingers";
  };

  test = ''
    has "delete 'com.apple.AppleMultitouchTrackpad' 'Dragging'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Dragging'"
    has "delete 'com.apple.AppleMultitouchTrackpad' 'DragLock'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'DragLock'"
    has "write 'com.apple.AppleMultitouchTrackpad' 'TrackpadThreeFingerDrag' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'TrackpadThreeFingerDrag' -bool 1"
  '';
}
