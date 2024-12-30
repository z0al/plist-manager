{ config, ... }:

{
  imports = [
    ../modules
  ];

  system.activationScripts.postActivation.text = ''
    echo "Activating plistManager"
    ${config.plist.out}
  '';
}
