{ config, pkgs, ... }:

let
  script = pkgs.writeShellScript "plist-darwin-activate" config.plist.out;
  fail = msg: "(printf '\\033[0;31m${msg}\\033[0m\n' && exit 1)";
in

{
  imports = [
    ../modules
  ];

  system.activationScripts.postActivation.text = ''
    echo "Activating plistManager"
    echo "└── Using ${script}"
    ${script} || ${fail "Failed to run ${script}"}
  '';
}
