{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    speed = 2;
    tapToClick = true;
    draggingStyle = "double-tap";
  };

  test = ''
    has "write -g 'com.apple.trackpad.scaling' -int 2"
    has "write 'com.apple.AppleMultitouchTrackpad' 'Clicking' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Clicking' -bool 1"

    # dragging style: double-tap
    has "write 'com.apple.AppleMultitouchTrackpad' 'Dragging' -bool 1"
    has "write 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'Dragging' -bool 1"
    has "delete 'com.apple.AppleMultitouchTrackpad' 'DragLock'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'DragLock'"
    has "delete 'com.apple.AppleMultitouchTrackpad' 'TrackpadThreeFingerDrag'"
    has "delete 'com.apple.driver.AppleBluetoothMultitouch.trackpad' 'TrackpadThreeFingerDrag'"
  '';
}
