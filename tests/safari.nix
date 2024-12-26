{ config, ... }:

let
  cfg = config.system.defaults.CustomUserPreferences;

  cfgSafari = cfg."com.apple.Safari";
  cfgSafariSandbox = cfg."com.apple.Safari.SandboxBroker";
in

{
  defaults.safari = {
    devTools.enable = true;
  };

  assertions = [
    {
      message = "expects showDevelopMenu to equal true";
      assertion = cfgSafariSandbox.ShowDevelopMenu == true;
    }

    {
      message = "expects webkit extra preference to be enabled";
      assertion = cfgSafari.WebKitDeveloperExtrasEnabledPreferenceKey == true;
    }

    {
      message = "expects webkit developer extras to be enabled";
      assertion = cfgSafari."WebKitPreferences.developerExtrasEnabled" == true;
    }
  ];
}
