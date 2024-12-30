{ lib, ... }:

{
  options.plist = {
    out = with lib; mkOption {
      type = types.lines;
      default = "";
      internal = true;
      visible = false;
    };
  };
}
