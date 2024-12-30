{ config, ... }:

{
  imports = [
    ../modules
  ];

  system.activationScripts.postActivation.text = ''
    echo "Activating plist-manager"
    ${config.defaults.out}
  '';
}
