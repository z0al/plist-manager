{ lib, ... }:

{
  imports = [
    ../modules

    (lib.mkAliasOptionModule
      [ "defaults" "_impl" ]
      [ "system" "defaults" "CustomUserPreferences" ])
  ];
}
