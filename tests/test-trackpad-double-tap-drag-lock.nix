{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    draggingStyle = "double-tap-lock";
  };

  test = ''
    has "write 'com.apple.AppleMultitouchTrackpad' 'Dragging' -bool true"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Dragging' -bool true"
    has "write 'com.apple.AppleMultitouchTrackpad' 'DragLock' -bool true"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'DragLock' -bool true"
    has "delete 'com.apple.AppleMultitouchTrackpad' 'TrackpadThreeFingerDrag'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'TrackpadThreeFingerDrag'"
  '';
}
