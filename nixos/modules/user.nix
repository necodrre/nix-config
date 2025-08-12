{ pkgs, user, name, ... }:

{
  programs.zsh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = name;
    extraGroups = [ "audio" "networkmanager" "wheel" ];
  };
  users.defaultUserShell = pkgs.zsh;
}
