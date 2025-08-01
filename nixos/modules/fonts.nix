{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.tinos
    nerd-fonts.monofur
    nerd-fonts.daddy-time-mono
    minecraftia
    monocraft
  ];
}
