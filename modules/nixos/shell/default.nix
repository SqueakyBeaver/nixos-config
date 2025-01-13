{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      plugins = ["git" "thefuck" "direnv"];
      theme = "robbyrussell";
    };
    enableCompletion = true;
    autosuggestions = {
      enable = true;
      strategy = [
        "completion"
        "match_prev_cmd"
        "history"
      ];
    };
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };
    shellInit = ''
        # Nix-direnv?
          nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          direnv allow
        fi
        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
          cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      mkShell {
        nativeBuildInputs = [
          bashInteractive
        ];
      }
      EOF
          $EDITOR default.nix
        fi
      }
      flakify() {
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
        $EDITOR flake.nix
      }

      # setup-direnv <lang>
      setup-direnv() {
        nix flake init --template github:the-nix-way/dev-templates#$1
      }

      # Too lazy to put this in a better place ;-;
      export PATH=$HOME/bin:$PATH
    '';
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  
}
