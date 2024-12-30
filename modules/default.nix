{ lib, ... }:

{
  imports = [
    ./desktop.nix
    ./dock.nix
    ./finder.nix
    ./safari.nix
  ];

  options.defaults = {
    out = with lib; mkOption {
      type = types.lines;
      default = "";
      internal = true;
      visible = false;
    };
  };
}
