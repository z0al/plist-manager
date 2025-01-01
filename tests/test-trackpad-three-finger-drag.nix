{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    draggingStyle = "three-fingers";
  };

  test = ''
    Domain com.apple.AppleMultitouchTrackpad
    Set TrackpadThreeFingerDrag true
    Del Dragging
    Del DragLock

    Domain com.apple.driver.AppleBluetoothMultitouch.trackpad
    Set TrackpadThreeFingerDrag true
    Del Dragging
    Del DragLock
  '';
}
