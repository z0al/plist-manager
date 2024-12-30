{ config, lib, ... }:

{
  imports = [
    ../modules
  ];

  home.activation.plist-manager = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.concatLines
      (map
        (cmd: "run ${cmd}")
        (lib.filter
          (v: lib.trim v != "")
          (lib.splitString "\n" config.defaults.out)))}
  '';
}
