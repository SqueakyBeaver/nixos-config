# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################
deploy *FLAGS:
    nixos-rebuild switch --flake . --sudo {{FLAGS}}


deploy-homelab *FLAGS:
    nixos-rebuild switch --flake .#homelab --target-host otter@homelab --sudo  {{FLAGS}}

boot-homelab *FLAGS:
    nixos-rebuild boot --flake .#homelab --target-host otter@homelab --sudo  {{FLAGS}}

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

# In case of sudden failure
# Should probably also edit ~/.zsh_history and fix it
repair *FLAGS:
    sudo nix-store --verify --check-contents --repair -v {{FLAGS}}
