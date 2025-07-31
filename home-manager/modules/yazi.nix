{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    plugins = with pkgs; {
      chmod = yaziPlugins.chmod;
      git = yaziPlugins.git;
      glow = yaziPlugins.glow;
      lazygit = yaziPlugins.lazygit;
      mediainfo = yaziPlugins.mediainfo;
      rsync = yaziPlugins.rsync;
    };
  };
}
