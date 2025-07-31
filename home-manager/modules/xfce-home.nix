{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = "";
      name = "Luna";
    };
    theme = {
      package = "https://github.com/matthewmx86/RedmondXP/tree/main/Theme/RedmondXP";
      name = "RedmondXP";
    };
    gtk3.extraConfig = {
      
    };
    gtk4.extraConfig = {
      
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent-enable = true;
}
