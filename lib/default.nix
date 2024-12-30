{ lib }:

let
  mkNullableOption = args:
    lib.mkOption (args // {
      type = lib.types.nullOr args.type;
      default = null;
    });

  mkCond = cond: value:
    if cond == true then value else null;

  writeDefaults = values:
    let

      toDomain = domain:
        if domain == "NSGlobalDomain" then "-g" else domain;

      toArg = value:
        let
          quote = val:
            "'${lib.strings.escape [ "'" ] val}'";
        in
        if lib.isBool value then "-bool ${toString value}"
        else if lib.isInt value then "-int ${toString value}"
        else if lib.isFloat value then "-float ${toString value}"
        else if lib.isString value then "-string ${quote (toString value)}"
        else abort "unsupported plist value"
      ;

      writeDefault = domain: key: value:
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
            lib.mapAttrsToList (writeDefault (toDomain domain)) attrs)
          values));
in

{
  inherit mkNullableOption mkCond writeDefaults;
}
