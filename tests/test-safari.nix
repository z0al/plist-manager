{
  imports = [
    ../modules/safari.nix
  ];

  defaults.safari = {
    devTools.enable = true;
  };

  test = ''
    has "write com.apple.Safari.SandboxBroker 'ShowDevelopMenu' -bool 1"
  '';
}
