{ config, lib, ... }:

{
  imports = [
    ../modules
  ];

  home.activation.plistManager = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.concatLines
      (map
        (cmd: "run ${cmd}")
        (lib.filter
          (v: lib.trim v != "")
          (lib.splitString "\n" config.plist.out)))}

    # Reload settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
