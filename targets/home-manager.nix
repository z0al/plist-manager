{ config, lib, ... }:

{
  imports = [
    ../modules
  ];

  targets.darwin.defaults = config.plist.out;

  home.activation.plistManager = lib.hm.dag.entryAfter [ "setDarwinDefaults" ] ''
    set -e
    ${config.plist.purgeScript}

    # Reload settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
