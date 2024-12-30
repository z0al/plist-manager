{ lib, ... }:

{
  options.defaults = {
    out = with lib; mkOption {
      type = types.lines;
      default = "";
      internal = true;
      visible = false;
    };
  };
}
