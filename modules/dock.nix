{ config, lib, ... }:

let
  cfg = config.defaults.dock;
in

{
  options.defaults.dock = with lib; {
    position = mkOption {
      description = ''
        Set the Dock position
      '';

      type = types.nullOr (types.enum [
        "bottom"
        "left"
        "right"
      ]);

      default = null;
    };
  };

  config.defaults._impl = {
    "com.apple.dock" = {
      orientation = cfg.position;
    };
  };
}
