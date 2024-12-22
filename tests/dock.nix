{ config, ... }:

let
  pref = config.system.defaults.CustomUserPreferences;
in

{
  defaults.dock = {
    position = "left";

    autoHide = {
      enable = true;
      delay = 0.5;
      animationDelay = 0.5;
    };
  };

  assertions = [
    {
      message = "expects dock position to equal 'left'";
      assertion = pref."com.apple.dock".orientation == "left";
    }

    {
      message = "expects dock auto-hide to be enabled";
      assertion = pref."com.apple.dock".autohide == true;
    }

    {
      message = "expects dock auto-hide delay to equal 0.5";
      assertion = pref."com.apple.dock".autohide-delay == 0.5;
    }

    {
      message = "expects dock auto-hide time modifier to equal 0.5";
      assertion = pref."com.apple.dock".autohide-time-modifier == 0.5;
    }
  ];
}
