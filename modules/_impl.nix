{ config, lib, ... }:

let
  purgePlist = defaults:
    let
      deletable = conf:
        lib.mapAttrs
          (domain: attrs:
            (lib.filterAttrs (n: v: v == null) attrs))
          conf;

      deleteAttrs = conf:
        lib.flatten (
          lib.mapAttrsToList
            (domain: attrs:
              lib.mapAttrsToList
                (key: _value: ''
                  /usr/bin/defaults delete '${
                    lib.escapeShellArg domain
                  }' '${lib.escapeShellArg key}' &> /dev/null || true
                '')
                attrs)
            conf);
    in
    lib.concatLines (deleteAttrs (deletable defaults));
in

{
  options.plist = with lib; {
    out = mkOption {
      type = with types;
        attrsOf (attrsOf (
          nullOr (oneOf [
            bool
            int
            float
            str
          ]))
        );
      description = ''
        Holds all user defaults assignment made by plist-manager. Its value gets
        assigned to either nix-darwin's `system.defaults.*` or home-manager's
        `targets.darwin.default.*`.
      '';
      default = { };
      internal = true;
      visible = false;
    };

    purgeScript = mkOption {
      type = types.lines;
      description = ''
        A script to purge all the unset user defaults. This won't be taken care
        of by default by either nix-darwin or home-manager
      '';
      default = "";
      internal = true;
      visible = false;
    };
  };

  config = {
    plist.purgeScript = purgePlist config.plist.out;
  };
}
