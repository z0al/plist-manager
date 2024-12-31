{
  imports = [
    ../modules/appearance.nix
  ];

  plist.appearance = {
    showScrollBar = "when-scrolling";
  };

  test = ''
    has "write -g 'AppleShowScrollBars' -string 'WhenScrolling'"
  '';
}
