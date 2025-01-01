{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    draggingStyle = "double-tap-lock";
  };

  test = ''
    Domain com.apple.AppleMultitouchTrackpad
    Set Dragging true
    Set DragLock true
    Del TrackpadThreeFingerDrag

    Domain com.apple.driver.AppleBluetoothMultitouch.trackpad
    Set Dragging true
    Set DragLock true
    Del TrackpadThreeFingerDrag
  '';
}
