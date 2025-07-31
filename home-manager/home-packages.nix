{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Browsers
    firefox
    lynx
    qutebrowser

    # Editors
    neovim
    helix

    # Terminal
    kitty    # GOAT

    # Shell
    zsh

    # CLI utilities
    aerc           # Email client
    appimage-run   # To run AppImage applications
    bottom         # Graphical process/system monitor with a customizable interface
    # dropbox-cli    # Command line client for dropbox daemon
    eza            # Modern replacement for `ls` command
    gh             # Github CLI
    just           # Handy way to save and run project-specific commands
    microfetch     # The "fastfetch" replacement written in Rust, exclusively for NixOS
                   # (creator assures it is really fast)
    neofetch       # Why not?
    silicon        # Creates beautiful pictures of your source code. Written in Rust btw
    yt-dlp         # Tool to download videos from Youtube and other sites (youtube-dl fork)
    wikiman        # Wikiman

    # Desktop applications
    dropbox           # Cloud file storage
    telegram-desktop  # Modern, and--probably the most popular nowadays--messanger
    obsidian          # Best thing that ever happened to me
    obs-studio        # Free software for video recording and live streaming
    # pavucontrol
    megasync          # "Mega Cloud Drive" desktop app
    prismlauncher     # Best minecraft launcher out there
    qutebrowser       # Keyboard-based browser
    showmethekey      # Show keys you typed on screen
    spotify           # Simply music
    thunderbird       # GUI email client
    nekoray           # "The only UI VPN/Proxy client that works on Linux"
    vesktop           # Alternative client for Discord

    # Wine
    wineWowPackages.stable  # For installing some windows stuff (bridge)
    winetricks

    # XFCE
    xfce.xfce4-whiskermenu-plugin

    # Other
    nix-prefetch-scripts
    protonmail-bridge     # required for bridging proton mail to the other email clients

    # For WM (Wayland)
    # bemoji         # Emoji picker with support for bemenu/wofi/rofi/dmenu and Wayland/X11
    # brightnessctl  # Allows to read and control device brightness
    # cliphist       # Wayland clipboard manager
    # fzf            # Fuzzy-finder written in Go
    # grimblast      # Helper for screenshots within Hyprland, based on grimshot
    # imv            # Command-line image viewer for tiling window managers
    # mediainfo      # Supplies technical and tag information about a video or audio file
  ];
}
