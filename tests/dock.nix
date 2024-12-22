{ config, ... }:

let
  pref = config.system.defaults.CustomUserPreferences;
in

{
  defaults.dock = {
    position = "left";
  };

  assertions = [
    {
      message = "expects dock position to equal 'left'";
      assertion = pref."com.apple.dock".orientation == "left";
    }
  ];
}
