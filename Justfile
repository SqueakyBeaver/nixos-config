# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################
deploy *FLAGS:
    nixos-rebuild switch --flake . --sudo {{FLAGS}}

deploy-homelab *FLAGS:
    nixos-rebuild switch --flake .#homelab --target-host otter@homelab --sudo --ask-sudo-password {{FLAGS}}

boot-homelab *FLAGS:
    nixos-rebuild boot --flake .#homelab --target-host otter@homelab --sudo --ask-sudo-password {{FLAGS}}

fast *FLAGS:
    nixos-rebuild switch --flake . --sudo --no-reexec {{FLAGS}}

test *FLAGS:
    nixos-rebuild test --flake . --sudo {{FLAGS}}

boot *FLAGS:
    nixos-rebuild boot --flake . --sudo {{FLAGS}}

up *FLAGS:
    nix flakes update {{FLAGS}}

debug *FLAGS:
   nixos-rebuild test --flake . --show-trace --verbose --sudo {{FLAGS}}

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
