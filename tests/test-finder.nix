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
    has "write -g 'AppleShowAllExtensions' -bool true"
    has "write 'com.apple.finder' 'AppleShowAllFiles' -bool true"
    has "write 'com.apple.finder' '_FXSortFoldersFirst' -bool true"
  '';
}
