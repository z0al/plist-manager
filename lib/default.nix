{ lib }:

let
  mkNullableOption = args:
    lib.mkOption (args // {
      type = lib.types.nullOr args.type;
      default = null;
    });

  mkCond = cond: value:
    if cond == true then value else null;

  writePlist = values:
    let
      toDomain = domain:
        if domain == "NSGlobalDomain" then "-g"
        else "'${lib.strings.escape [ "'" ] domain}'";

      toArg = value:
        let
          quote = val:
            "'${lib.strings.escape [ "'" ] val}'";
        in
        if value == true then "-bool true"
        else if value == false then "-bool false"
        else if lib.isInt value then "-int ${toString value}"
        else if lib.isFloat value then "-float ${toString value}"
        else if lib.isString value then "-string ${quote (toString value)}"
        else abort "unsupported plist value"
      ;

      writeOrDelete = domain: key: value:
        if value == null then
          "/usr/bin/defaults delete ${domain} '${key}' &> /dev/null || true"
        else
          "/usr/bin/defaults write ${domain} '${key}' ${toArg value}"
      ;
    in
    lib.concatLines (
      lib.flatten (
        lib.mapAttrsToList
          (domain: attrs:
            lib.mapAttrsToList (writeOrDelete (toDomain domain)) attrs)
          values));
in

{
  inherit mkNullableOption mkCond writePlist;
}
