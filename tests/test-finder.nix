{
  imports = [
    ../modules/finder.nix
  ];

  plist.finder = {
    showHidden = true;
    showExtensions = true;
    keepFoldersOnTop = true;
  };

  test = ''
    has "write -g 'AppleShowAllExtensions' -bool 1"
    has "write 'com.apple.finder' 'AppleShowAllFiles' -bool 1"
    has "write 'com.apple.finder' '_FXSortFoldersFirst' -bool 1"
  '';
}
