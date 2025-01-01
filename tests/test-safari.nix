{
  imports = [
    ../modules/safari.nix
  ];

  plist.safari = {
    devTools.enable = true;
  };

  test = ''
    Domain com.apple.Safari.SandboxBroker
    Set ShowDevelopMenu true
  '';
}
