{
  defaults.dock = {
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
    has "write com.apple.dock 'orientation' -string 'left'"
    has "write com.apple.dock 'tilesize' -int 24"
    has "write com.apple.dock 'show-recents' -bool"
    has "write com.apple.dock 'autohide' -bool 1"
    has "write com.apple.dock 'autohide-delay' -float 0.500000"
    has "write com.apple.dock 'autohide-time-modifier' -float 0.500000"
    has "write com.apple.dock 'mineffect' -string 'scale'"
    has "write com.apple.dock 'minimize-to-application' -bool"
  '';
}
