{ config, ... }:

let
  pref = config.system.defaults.CustomUserPreferences;
in

{
  defaults.dock = {
    position = "left";
    size = 24;
    showRecentApps = false;

    autoHide = {
      enable = true;
      delay = 0.5;
      animationDelay = 0.5;
    };

    minimize = {
      effect = "scale";
      toApplicationIcon = false;
    };
  };

  assertions = [
    {
      message = "expects dock position to equal 'left'";
      assertion = pref."com.apple.dock".orientation == "left";
    }

    {
      message = "expects dock size to equal 24";
      assertion = pref."com.apple.dock".tilesize == 24;
    }

    {
      message = "expects dock to not show recent apps";
      assertion = pref."com.apple.dock".show-recents == false;
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

    {
      message = "expects dock minimize effect to equal 'scale'";
      assertion = pref."com.apple.dock".mineffect == "scale";
    }

    {
      message = "expects dock minimize to not minimize to application icon";
      assertion = pref."com.apple.dock".minimize-to-application-icon == false;
    }
  ];
}
