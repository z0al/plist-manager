{ lib }:

let
  mkNullableOption = args:
    lib.mkOption (args // {
      type = lib.types.nullOr args.type;
      default = null;
    });

  mkCond = cond: value:
    if cond == true then value else null;
in

{
  inherit mkNullableOption mkCond;
}
