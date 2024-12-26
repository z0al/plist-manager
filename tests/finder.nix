{ config, ... }:

let
  cfg = config.system.defaults.CustomUserPreferences;
in

{
  defaults.finder = {
    showHidden = true;
    showExtensions = true;
    keepFoldersOnTop = true;
  };

  assertions = [
    {
      message = "expects Finder to show hidden files";
      assertion = cfg."com.apple.finder".AppleShowAllFiles == true;
    }

    {
      message = "expects Finder to show file extensions";
      assertion = cfg.NSGlobalDomain.AppleShowAllExtensions == true;
    }

    {
      message = "expects Finder to keep folders on top when sorting";
      assertion = cfg."com.apple.finder"._FXSortFoldersFirst == true;
    }
  ];
}
