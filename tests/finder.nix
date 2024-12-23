{ config, ... }:

let
  pref = config.system.defaults.CustomUserPreferences;
in

{
  defaults.finder = {
    showHidden = true;
    showExtensions = true;
  };

  assertions = [
    {
      message = "expects Finder to show hidden files";
      assertion = pref.NSGlobalDomain.AppleShowAllExtensions == true;
    }

    {
      message = "expects Finder to show file extensions";
      assertion = pref.com.apple.finder.AppleShowAllFiles == true;
    }
  ];
}
