{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.just
  ];
  programs = {
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
}
