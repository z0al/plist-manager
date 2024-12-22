{ lib, ... }:

{
  imports = [
    ../modules

    (lib.mkAliasOptionModule
      [ "defaults" "_impl" ]
      [ "targets" "darwin" "currentHostDefaults" ])
  ];
}
