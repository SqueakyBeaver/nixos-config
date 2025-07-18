# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################
deploy:
    nixos-rebuild switch --file ./nilla.nix --attr systems.nixos.thinkpad.result --sudo

fast:
    nixos-rebuild switch --file ./nilla.nix --attr systems.nixos.thinkpad.result --sudo --no-reexec

test:
    nixos-rebuild test --file ./nilla.nix --attr systems.nixos.thinkpad.result --sudo

boot:
    nixos-rebuild boot --file ./nilla.nix --attr systems.nixos.thinkpad.result --sudo

up:
    npins update

debug:
   nixos-rebuild test --file ./nilla.nix --attr systems.nixos.thinkpad.result --show-trace --verbose --sudo

# Get the gc roots that are most likely created by nix-direnv
roots:
    nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/\w+-system|\{memory|/proc)"

# In case of sudden failure
# Should probably also edit ~/.zsh_history and fix it
repair:
    sudo nix-store --verify --check-contents --repair -v
