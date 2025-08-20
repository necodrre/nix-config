{ config, homeStateVersion, user, ... }:

{
  imports = [
    ./modules
    ./home-packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
    EDITOR = "hx";
    VISUAL = "hx";
    NH_FLAKE = "${config.home.homeDirectory}/.config/nix-config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
