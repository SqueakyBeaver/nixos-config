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

#
# deploy:
#   nixos-rebuild switch --flake . --use-remote-sudo
#
# fast:
#   nixos-rebuild switch --flake . --use-remote-sudo --fast
#
# test:
#   nixos-rebuild test --flake . --use-remote-sudo
#
# debug:
#   nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose
#
# up:
#   nix flake update
#
# # When you need to change vscode extensions
# # WARNING: WILL REMOVE ~/.vscode
# vscode:
#   -rm -r ~/.vscode
#   -pkill code
#   nixos-rebuild switch --flake . --use-remote-sudo
#
# # Update specific input
# # usage: make upp i=home-manager
# upp:
#   nix flake update $(i)
#
# history:
#   nix profile history --profile /nix/var/nix/profiles/system
#
# repl:
#   nix repl -f flake:nixpkgs
#
# clean:
#   # remove all generations older than 7 days
#   sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
#
# gc:
#   # garbage collect all unused nix store entries
#   sudo nix-collect-garbage --delete-old
#   nix-collect-garbage --delete-old
