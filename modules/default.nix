{ pkgs, lib, ... }:

let
  inherit (pkgs.callPackage ../lib { }) mkNullableOption;
in

{
  imports = [
    ./desktop.nix
    ./dock.nix
    ./finder.nix
    ./safari.nix
  ];

  options.defaults._impl = with lib; mkNullableOption {
    type = types.attrsOf types.anything;
    default = { };
    internal = true;
    visible = false;
  };
}
