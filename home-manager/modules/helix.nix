{ lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    # This will generate config itself
    settings = {
      theme = "rat";
    };
    extraConfig = builtins.readFile ./helix.toml;

    languages.language = [
      {
        name = "rust";
        indent = {
            tab-width = 4;
            unit = "    ";
        };
        # auto-format = true;
        # formatter.command = lib.getExe pkgs.rustfmt;
      }
      {
        name = "nix";
        indent = {
            tab-width = 2;
            unit = "  ";
        };
        # auto-format = true;
        # formatter.command = lib.getExe pkgs.nixpkgs-fmt;
      }
      {
        name = "go";
        indent = {
            tab-width = 4;
            unit = "    ";
        };
        auto-format = false;
        file-types = [ "go" ];
        # auto-format = true;
      }
      {
        name = "c";
        indent = {
            tab-width = 8;
            unit = "        ";
        };
      }
    ];

    themes = {
      rat = let
        # kanagawa-dragon
        dragonBlack4 = "#282727";
        dragonBlack6 = "#625e5a";
        # kanagawa
        roninYellow = "#FF9E3B";  # diagnostic warning
      in {
        "inherits" = "base16_default_dark";
        "ui.gutter" = { fg = dragonBlack6; bg = dragonBlack4; };
        "ui.linenr" = { fg = dragonBlack6; bg = dragonBlack4; };
        "ui.linenr.selected" = { fg = roninYellow; modifiers = ["bold"]; };
        "ui.cursor.match" = { fg = roninYellow; modifiers = ["bold"]; };
      };
    };
  };
}
