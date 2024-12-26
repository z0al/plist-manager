{ config, ... }:

{
  imports = [
    ../modules
  ];

  system.defaults.CustomUserPreferences = config.defaults._impl;
}
