# System-wide common configuration
# I want all these setting to be present on all my hosts
{ config, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Essentials
    mesa         # 3D Graphics library
    pciutils     # PCIUtils...
    usbutils     # Used for lsusb
    lsscsi       # List SCSI devices (or hosts)
    lshw         # List hardware configuration
    samba        # For winbindd/ntlm_auth packages
    gcc          # C Compiler (classic)
    go           # Go Compiler
    clang        # C Compiler ("modern")
                   # Also installs:
                   #   1. clang-format
                   #   2. clangd (C/C++ LSP)
    clang-tools  # Standalone command-line tools for C++
    cargo        # Rust build tool and package manager
    rustc        # Rust Compiler
    gnumake      # C Build tool
    cmake        # C++ Build tool
    git          # Version Control System
    git-graph    # Command line tool to show clear git graphs
    wget         # Tool for retrieving files using HTTP(S) and FTP
    p7zip        # Working with archives
    pax          # A great alternative to "tar" (Tape Archive)
    mpv          # Media player
    ffmpeg       # I use for convertion formats
    gnupg        # Encryption etc. etc. etc.

    # LSP Servers
    gopls                 # Go LSP
    rust-analyzer         # Rust LSP
    nil                   # Nix LSP
    ruff                  # Python LSP
    bash-language-server  # Bash LSP

    # Debug
    gdb       # C/C++ Debugger
    lldb      # LLVM Deubgger
    valgrind  # Memory debugging tool

    # CLI Tools
    bat            # The `cat` clone with syntax highlighting and git integration
    bc             # GNU Software calculator
    btop           # Monitor of Resources
    fastfetch      # Better neofetch
    gdb-dashboard  # Visual interface for GDB
    lazygit        # Simple terminal UI for git commands
    mutt           # Email client
    ripgrep        # The combination of usability of The Silver Searcher with the
                   # raw speed of `grep`
    tldr           # Best thing ever
    tree           # The tree-based `ls` replacement
    xclip          # Tool to access the X clipboard from a console
    wl-clipboard   # Command-line copy/paste utilities for Wayland
    yazi           # Terminal-based file manager

    # Other
    nix-prefetch-scripts
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
