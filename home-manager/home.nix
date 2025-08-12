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
    NIXOS_CONFIG_PATH = "${config.home.homeDirectory}/.config/nix-config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
