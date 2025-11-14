{
  config,
  pkgs,
  project,
  ...
}: {
  environment.systemPackages =
    [
      # Nilla stuff
      (project.inputs.nilla-cli.result.packages.default.result.${pkgs.system})
      (project.inputs.nilla-nixos.result.packages.default.result.${pkgs.system})
      (project.inputs.nilla-home.result.packages.default.result.${pkgs.system})

      pkgs.just
      pkgs.rocmPackages.rocm-smi # For btop gpu monitoring (hope)
    ]
    ++ (with pkgs.fishPlugins; [
      pkgs.fzf
      fzf-fish
      done
      spark
      forgit
      hydro
      grc
      pkgs.grc
    ]);
  programs = {
    adb.enable = true;

    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        # setup-direnv <lang>
        function setup-direnv
          nix flake init --template github:the-nix-way/dev-templates#$argv[1]
        end

        # Too lazy to put this in a better place ;-;
        set -p PATH $HOME/bin
      '';
    };

    zsh = {
      enable = true;

      ohMyZsh = {
        enable = true;
        plugins = ["git" "direnv"];
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
        # setup-direnv <lang>
        setup-direnv() {
          nix flake init --template github:the-nix-way/dev-templates#$1
        }

        # Too lazy to put this in a better place ;-;
        export PATH=$HOME/bin:$PATH
      '';

      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${ZSH_EXECUTION_STRING} ]]
        then
          if [[ $LOGIN_SHELL == 1 ]]; then
            LOGIN_OPTION='--login'
          else
            LOGIN_OPTION=""
          fi
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    starship = {
      enable = true;

      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };

  # Because of slow fish stuff
  documentation.man.generateCaches = false;
}
