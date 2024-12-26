{ config, ... }:

let
  cfg = config.system.defaults.CustomUserPreferences;
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
  ];
}
