{ lib, ... }:

let
  reload = ''
    # Reload settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
in

{
  options.plist = {
    out = with lib; mkOption {
      type = types.lines;
      default = "";
      apply = writes: ''
        set -e

        ${writes}

        ${reload}
      '';

      internal = true;
      visible = false;
    };
  };
}
