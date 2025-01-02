{ config, ... }:

{
  imports = [
    ../modules
  ];

  system.defaults.CustomUserPreferences = config.plist.out;

  system.activationScripts.postActivation.text = ''
    echo "Activating plistManager"

    ${config.plist.purgeScript}

    # Reload settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
