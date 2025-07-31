{ config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "zhann";
      plugins = [
        "git"
      ];
    };

    shellAliases = {
      # List directory contents
      ll = "eza --color=always -lah";
      ls="eza --color=always -a";
      tree="eza --tree --git-ignore";

      # Utilities
      cat = "bat --theme=gruvbox-dark";

      # Misc
      # c = "clear"     # Better to use "Ctrl + L" hotkey
      # hs = "history"  # Better to use "Ctrl + R" hotkey
      j = "just";
      fetch = "clear && fastfetch --logo gentoo";
      # fetch = "clear && fastfetch --logo windows";

      # Network
      ip = "ip --color=auto";
      intfs = "ip -br a";
      myip = "curl http://ipecho.net/plain; echo";
      wimp = "curl ifconfig.me; echo";  # What Is My Ip
      ports = "netstat - tulanp";

      # Shortcuts
      lg = "lazygit";
      se = "sudoedit";
      ".." = "cd ..";

      # Git
      cdr = "(){ cd $(git rev-parse --show-toplevel); }";  ## "cd" to the root of the current repository

      # NixOS
      nixgens = "nixos-rebuild list-generations";
      homegens = "home-manager generations";
      clean-boot = "sudo /run/current-system/bin/switch-to-configuration boot";
      nix-full-upgrade = "sudo nix-channel --update && sudo nixos-rebulid switch && home-manager switch && clean-boot && reboot";
      # nr = "sudo nixos-rebuild switch --flake ${env.flakePath}";      # Rebuild and switch
      # nb = "sudo nixos-rebuild build --flake ${env.flakePath}";       # Build without switch
      # nrd = "sudo nixos-rebuild dry-build --flake ${env.flakePath}";  # Preview changes

      # System maintenance docs
      # nixos-rebuild list-generations              # List system generations
      # nix-collect-garbage -d (--delete-old)       # Clean old user generations
      # sudo nix-collect-garbage -d (--delete-old)  # Clean system-wide
      # sudo /run/current-system/bin/switch-to-configuration boot  # Clean boot entries
      # sudo nix flake update                       # Update flake inputs

      # Misc
      sirus = "appimage-run ~/SirusLauncher.AppImage";
    };

    history.size = 10000;

    # zsh-abbr = {
    #   enable = true;
    #   abbreviations = shellAliases;  # <-- Use aliases
    # };

    initContent = ''
      ###################################################
      ## Preferred editor on local and remote sessions ##
      ###################################################
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
      else
        export EDITOR='hx'
      fi

      ###############################
      ## Open man pages via neovim ##
      ###############################
      export MANPAGER="nvim +Man! -"

      #############################################################
      ## Export Go path (because I have no flakes installed yet) ##
      #############################################################
      # export PATH=$PATH:/usr/local/go/bin

      #######################
      ## Git pull on enter ##
      #######################
      autoload -Uz chpwd_functions
      chpwd_functions+=(auto_git_pull)

      auto_git_pull() {
        if [[ -d .git ]]; then
          echo "Pulling latest changes..."
          git pull --ff-only
        fi
      }

      ########################################################
      ## Fix sound cracking in applications opened via Wine ##
      ########################################################
      export WINENOPULSE=1

      #############
      ## Aliases ##
      #############
      if [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
        alias -- clrd='xclip -selection clipboard'  # Stand for "CLipboaRD"
        alias -- cdp='pwd | xclip -selection clipboard'  # Copy directory path (X11)
        alias -- cfp='(){ readlink -f $1 | xclip -selection clipboard}'  # Copy file path (X11)
      else
        alias -- cdp='pwd | wl-copy'  # Copy dir path (Wayland)
        alias -- cfp='(){ readlink -f $1 | wl-copy; }'  # Copy file path (Wayland)
      fi
    '';
  }; 
}
