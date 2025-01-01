{
  imports = [
    ../modules/dock.nix
  ];

  plist.dock = {
    position = "left";
    size = 24;
    showRecentApps = false;

    autoHide = {
      enable = true;
      delay = 0.5;
      animationDelay = 0.5;
    };

    minimize = {
      effect = "scale";
      toApplicationIcon = false;
    };
  };


  test = ''
    Domain com.apple.dock
    Set orientation '"left"'
    Set tilesize 24
    Set show-recents false
    Set autohide true
    Set autohide-delay 0.5
    Set autohide-time-modifier 0.5
    Set mineffect '"scale"'
    Set minimize-to-application false
  '';
}
