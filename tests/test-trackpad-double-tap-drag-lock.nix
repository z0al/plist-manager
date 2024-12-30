{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    draggingStyle = "double-tap-lock";
  };

  test = ''
    has "write 'com.apple.AppleMultitouchTrackpad' 'Dragging' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Dragging' -bool 1"
    has "write 'com.apple.AppleMultitouchTrackpad' 'DragLock' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'DragLock' -bool 1"
    has "delete 'com.apple.AppleMultitouchTrackpad' 'TrackpadThreeFingerDrag'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'TrackpadThreeFingerDrag'"
  '';
}
