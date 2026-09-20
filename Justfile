# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

alias deploy := switch
alias deploy-homelab := switch-homelab


switch *FLAGS:
    nh os switch . {{FLAGS}}

switch-homelab *FLAGS:
    nh os switch .#homelab --target-host otter@homelab {{FLAGS}}

boot-homelab *FLAGS:
    nh os boot .#homelab --target-host otter@homelab {{FLAGS}}

test *FLAGS:
    nh os test . {{FLAGS}}

boot *FLAGS:
    nh os boot . {{FLAGS}}

up *FLAGS:
    nix flakes update {{FLAGS}}

debug *FLAGS:
   nh os test . --show-trace --verbose {{FLAGS}}

# Get the gc roots that are most likely created by nix-direnv
roots:
    nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"

# Same as roots, except it filters the output to only show the .direnv paths
direnv-roots:
    nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)" | awk -F '\.direnv' '/direnv/ { print $1 ".direnv" }'

ssh-to-sops:
    #! /usr/bin/env bash
    set -euxo pipefail

    mkdir -p ~/.config/sops/age

    if [ -a ~/.config/sops/age/keys.txt ]; then
        mv --backup="numbered" ~/.config/sops/age/keys.txt ~/.config/sops/age/keys.txt.bak

    nix-shell -p ssh-to-age --run "systemd-ask-password | ssh-to-age -private-key -i ~/.ssh/id_ed25519 -stdinpass > ~/.config/sops/age/keys.txt"
    echo "AGE Public Key: "
    nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"


# In case of sudden failure
# Should probably also edit ~/.zsh_history and fix it
repair *FLAGS:
    sudo nix-store --verify --check-contents --repair -v {{FLAGS}}
