{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.rat = {
    isNormalUser = true;
    description = "lynette";
    extraGroups = [ "audio" "networkmanager" "wheel" ];
  };
  users.defaultUserShell = pkgs.zsh;
}
