{ config, ... }:

{
  imports = [
    ../modules
  ];

  targets.darwin.currentHostDefaults = config.defaults._impl;
}
