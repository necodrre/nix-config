{ config, user, ...}: {
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

    shellAliases =
    let
      flakePath = config.home.sessionVariables.NIXOS_CONFIG_PATH;
    in
    {
      # List directory contents
      ll = "eza --color=always -lah";
      ls="eza --color=always -a";
      tree="eza --tree --git-ignore";

      # Utilities
      cat = "bat --theme=gruvbox-dark";

      # Misc
      j = "just";
      fetch = "clear &&  fastfetch --structure \" \" --logo gentoo --logo-padding-left $(($(tput cols)/4 + $(tput cols)/7)) | lolcat -as 200 -S 75 && echo && fastfetch --logo none --key-padding-left $(($(tput cols)/4 + $(tput cols)/7))";
      # clear && \
      # fastfetch --structure " " --logo gentoo --logo-padding-left \
      #   $(($(tput cols)/4 + $(tput cols)/7)) | lolcat -as 200 -S 75 && \
      #   echo && \
      #   fastfetch --logo none --key-padding-left $(($(tput cols)/4 + $(tput cols)/7))
      fetchwin = "clear && fastfetch --logo windows";
      catext = "(){ find . -name \"*.$1\" -not -path './.git/*' -exec printf \"\\n\\n{}\\n\\n\\n\" \\; -exec bat -pp {} \\; }";
      rgdirext = "(){ find . -name \"*.$1\" -not -path './.git/*' -exec bash -c 'for f in \"$1\"; do if rg -q \"$2\" \"$f\"; then printf \"\\n$f\\n\\n\"; rg \"$2\" \"$f\"; fi; done' none {} \"$2\" \\; }";
      # find . -name '*.<extension>' -not -path './.git/*'
      #   -exec bash -c 'for f in "$1"; do
      #                    if rg -q "<pattern>" "$f"; then
      #                      printf "\n$f\n\n";
      #                      rg "<pattern>" "$f";
      #                    fi;
      #                  done'
      #   none {} "$2" \;
      rgdir = "(){ find . -name \"*\" -not -path './.git/*' -exec bash -c 'for f in \"$1\"; do if rg -q \"$2\" \"$f\"; then printf \"\\n$f\\n\\n\"; rg \"$2\" \"$f\"; fi; done' none {} \"$1\" \\; }";
      # find . -name '*' -not -path './.git/*'
      #   -exec bash -c 'for f in "$1"; do
      #                    if rg -q "<pattern>" "$f"; then
      #                      printf "\n$f\n\n";
      #                      rg "<pattern>" "$f";
      #                    fi;
      #                  done'
      #   none {} "$1" \;
      get-alias = "() { printf '%s\\n' $aliases[$1] }";

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

      # List generations
      nixgens = "nixos-rebuild list-generations";
      homegens = "home-manager generations";
      # Clean the system (system-wide: nixos + home-manager)
      nix-clean-sw = "sudo nh clean all --keep=3";
      clean-boot = "sudo /run/current-system/bin/switch-to-configuration boot";
      # Update/Switch/Build
      nix-update = "nh os switch --update ${flakePath}";
      nix-switch = "nh os switch --ask ${flakePath} && clean-boot";
      nix-build = "nh os build ${flakePath}";
      home-switch = "nh home switch --ask ${flakePath} && source /home/${user}/.zshrc";
      home-build = "nh home build ${flakePath}";
      # Full system upgrade
      nix-full-upgrade = "nix-update && nix-switch && home-switch && reboot";
      # Preview changes without performing them
      nix-preview = "nh os switch --dry ${flakePath}";
      home-preview = "nh home switch --dry ${flakePath}";
      # Change directory to configuration directory
      cdconf = "cd $NIXOS_CONFIG_PATH";
      # nvd shortcut: compare two generations
      nvd-nix = "(){ nvd diff /nix/var/nix/profiles/system-{\"$1\",\"$2\"}-link }";

      # home-switch = "home-manager switch --flake .#${user} && source /home/${user}/.zshrc";
      # nix-switch = "sudo nixos-rebuild switch --flake .#${hostname} && clean-boot";
      # nix-full-upgrade = "nix-update && nix-switch && home-switch && reboot";

      # Misc
      sirus = "appimage-run ~/SirusLauncher.AppImage";
      circle = "wine ~/Games/World\\ of\\ Warcraft/3.3.5\\ \\(ENG\\)/Wow.exe";
    };

    history.size = 10000;

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

    # zsh-abbr = {
    #   enable = true;
    #   abbreviations = shellAliases;  # <-- Use aliases
    # };
}
