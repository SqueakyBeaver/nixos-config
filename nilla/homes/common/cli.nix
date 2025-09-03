{
  config,
  pkgs,
  lib,
  project,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar
    p7zip

    # misc
    libnotify
    openssl

    # utils
    killall
    duf
    fd
    file
    jaq
    ripgrep
    just
    which
    tree
    btop-rocm
    iotop
    iftop
    sops
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza.enable = true;
    ssh = {
      enable = true;
      matchBlocks."*" = {
        addKeysToAgent = "confirm";
        forwardAgent = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        compression = false;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
    zsh.enable = true;
    nix-index.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      # FIXME: If you copy this, change it
      userName = "Beaverr";
      userEmail = "squeaky.beaver4133@protonmail.com";

      # https://blog.gitbutler.com/how-git-core-devs-configure-git/
      extraConfig = {
        column = {
          ui = "auto";
        };
        branch = {
          sort = "-committerdate";
        };
        tag = {
          sort = "version:refname";
        };
        init = {
          defaultBranch = "main";
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        # Why the hell not?
        help = {
          autocorrect = "prompt";
        };
        commit = {
          verbose = true;
        };
        rerere = {
          enabled = true;
          autoupdate = true;
        };
        core = {
          excludesfile = "~/.gitignore";
          # fsmonitor = true; # Personal taste
          # untrackedCache = true; # Personal taste
        };
        rebase = {
          autoSquash = true;
          autoStash = true;
          updateRefs = true;
        };
        merge = {
          conflictstyle = "zdiff3"; # Personal taste
        };
        pull = {
          rebase = true; # Personal taste
        };
      };
    };

    jujutsu = {
      enable = true;

      settings = {
        user = {
          name = "Beaverr";
          email = "squeaky.beaver4133@protonmail.com";
        };

        signing = {
          behavior = "own";
          backend = "ssh";
          # It's fine, it's just a public key (I hope it's fine .-.)
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMoljotaFu7Cb75gS0MD6fbqtKrxurAmkesi70xRtV7";
        };

        ui = {
          editor = "nvim";
          diff-editor = "nvimdirdiff";
          merge-editor = "nvimdirdiff";
        };

        merge-tools.nvimdiffconflicts = {
          program = "nvim";
          merge-args = [
            "-c"
            "let g:jj_diffconflicts_marker_length=$marker_length"
            "-c"
            "JJDiffConflicts!"
            "$output"
            "$base"
            "$left"
            "$right"
          ];
          merge-tool-edits-conflict-markers = true;
        };
      };
    };

    alacritty = {
      enable = true;

      settings = {
        window = {
          startup_mode = "Windowed";
          padding = {
            x = 20;
            y = 20;
          };
        };

        font = lib.mkDefault {
          normal = {
            family = "Fira Code";
            style = "Regular";
          };
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
          vi_mode_style = {
            shape = "Block";
            blinking = "On";
          };
        };
      };
    };

    tmux = {
      enable = true;
      aggressiveResize = true;
      clock24 = true;
      customPaneNavigationAndResize = true;
      focusEvents = true;
      mouse = true; # I will 100% forget keybinds
      newSession = true;
      secureSocket = false;
      tmuxp.enable = true;
      plugins = with pkgs; [
        tmuxPlugins.better-mouse-mode
        tmuxPlugins.fzf-tmux-url
        tmuxPlugins.tmux-which-key
        tmuxPlugins.tmux-powerline
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.tmux-thumbs
      ];
      extraConfig = ''
        set -as terminal-features ",alacritty*:RGB"
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy && wl-paste -n | wl-copy -p"
        bind-key p run "wl-paste -n | tmux load-buffer - ; tmux paste-buffer"

        bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
        set -g detach-on-destroy off  # don't exit from tmux when closing a session
      '';
    };

    sesh = {
      enable = true;
      settings = {
        session = [
          {
            name = "nixos-config";
            path = "~/nixos-config";
            startup_command = "nvim .";
          }
        ];
      };
    };

    fzf.tmux.enableShellIntegration = true;


    # Open sesh with Alt-s
    zsh.initContent = ''
      function sesh-sessions() {
        {
          exec </dev/tty
          exec <&1
          local session
          session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
          zle reset-prompt > /dev/null 2>&1 || true
          [[ -z "$session" ]] && return
          sesh connect $session
        }
      }

      zle     -N             sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions
    '';

    zoxide = {
      enable = true;
      options = [
        "--cmd=cd"
      ];
    };
  };

  services.ssh-agent.enable = true;

  # Workaround for bad ~/.ssh/config file permissions
  home.file = {
    ".ssh/config" = {
      target = ".ssh/config_source";
      onChange = ''cat .ssh/config_source > .ssh/config && chmod 400 .ssh/config'';
    };
  };
}
