{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { }).customize{
      name = "vim";
      vimrcConfig.customRC = builtins.readFile ./vimrc;
    })
  ];
}
