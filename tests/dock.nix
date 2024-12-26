{ config, ... }:

let
  cfg = config.system.defaults.CustomUserPreferences."com.apple.dock";
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
      assertion = cfg.orientation == "left";
    }

    {
      message = "expects dock size to equal 24";
      assertion = cfg.tilesize == 24;
    }

    {
      message = "expects dock to not show recent apps";
      assertion = cfg.show-recents == false;
    }

    {
      message = "expects dock auto-hide to be enabled";
      assertion = cfg.autohide == true;
    }

    {
      message = "expects dock auto-hide delay to equal 0.5";
      assertion = cfg.autohide-delay == 0.5;
    }

    {
      message = "expects dock auto-hide time modifier to equal 0.5";
      assertion = cfg.autohide-time-modifier == 0.5;
    }

    {
      message = "expects dock minimize effect to equal 'scale'";
      assertion = cfg.mineffect == "scale";
    }

    {
      message = "expects dock minimize to not minimize to application icon";
      assertion = cfg.minimize-to-application-icon == false;
    }
  ];
}
