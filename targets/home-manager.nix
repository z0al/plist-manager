{ config, pkgs, lib, ... }:

let
  script = pkgs.writeShellScript "plist-home-activate" config.plist.out;
  fail = msg: "(printf '\\033[0;31m${msg}\\033[0m\n' && exit 1)";
in

{
  imports = [
    ../modules
  ];

  home.activation.plistManager = lib.hm.dag.entryAfter [ "setDarwinDefaults" ] ''
    echo "└── Using ${script}"
    run ${script} || ${fail "Failed to run ${script}"}
  '';
}
