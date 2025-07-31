{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font = {
      package = pkgs.nerd-fonts.hack;
      name = "Hack-Regular";
      size = 11;
    };
  };
}
