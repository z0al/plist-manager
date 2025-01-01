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
    Domain NSGlobalDomain
    Set AppleShowAllExtensions true

    Domain com.apple.finder
    Set AppleShowAllFiles true
    Set _FXSortFoldersFirst true
  '';
}
