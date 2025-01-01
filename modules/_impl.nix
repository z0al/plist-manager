{ pkgs, lib, ... }:

let
  writePlist = configuration: with lib;
    let
      # We can only serialize values that are not null to *.plist files
      # The rest will be mapped to deletion commands
      writable = conf:
        mapAttrs
          (domain: attrs:
            (filterAttrs (n: v: v != null) attrs))
          conf;

      deletable = conf:
        mapAttrs
          (domain: attrs:
            (filterAttrs (n: v: v == null) attrs))
          conf;

      toPlist = domain: attrs:
        pkgs.writeText "${domain}.plist" (generators.toPlist { } attrs);

      importAttrs = conf:
        mapAttrsToList
          (domain: attrs: ''
            /usr/bin/defaults import '${
              escapeShellArg domain
            }' ${toPlist domain attrs}
          '')
          conf;

      deleteAttrs = conf:
        flatten (
          mapAttrsToList
            (domain: attrs:
              mapAttrsToList
                (key: _value: ''
                  /usr/bin/defaults delete '${
                    escapeShellArg domain
                  }' '${escapeShellArg key}'
                '')
                attrs)
            conf);
    in
    concatLines (
      (importAttrs (writable configuration)) ++
      (deleteAttrs (deletable configuration))
    );

  reload = ''
    # Reload settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
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
      default = { };
      internal = true;
      visible = false;
      apply = value: ''
        set -e

        ${writePlist value}
        ${reload}
      '';
    };
  };
}
