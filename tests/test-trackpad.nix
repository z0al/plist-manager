{
  imports = [
    ../modules/trackpad.nix
  ];

  plist.trackpad = {
    speed = 2;
    tapToClick = true;
    naturalScrolling = true;
    draggingStyle = "double-tap";
  };

  test = ''
    Domain NSGlobalDomain
    Set com.apple.trackpad.scaling 2
    Set com.apple.swipescrolldirection true

    Domain com.apple.AppleMultitouchTrackpad
    Set Clicking true
    Set Dragging true
    Del DragLock
    Del TrackpadThreeFingerDrag

    Domain com.apple.driver.AppleBluetoothMultitouch.trackpad
    Set Clicking true
    Set Dragging true
    Del DragLock
    Del TrackpadThreeFingerDrag
  '';
}
