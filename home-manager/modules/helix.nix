{
  programs.helix = {
    enable = true;

    settings = {
      theme = "rat";

      editor = {
        true-color = true;
        # auto-save = true;
        shell = ["zsh" "-c"];
        line-number = "relative";
        auto-info = true;
        auto-format = false;
        text-width = 80;
        # soft-wrap.max-indent-retain = 80;
        end-of-line-diagnostics = "hint";
        auto-pairs = true;
      };

      editor.statusline = {
        separator = "|";
        left = [
          "mode"
          "spinner"
          "diagnostics"
          # "file-name"
          # "file-absolute-path"
          "file-base-name"
          "read-only-indicator"
          "file-modification-indicator"
        ];
        center = [
          "position"
          "separator"
          "total-line-numbers"
          "separator"
          "spacer"
          "position-percentage"
        ];
        right = [
          "selections"
          "register"
          "file-type"
          "file-encoding"
        ];
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
      };

      editor.lsp = {
        enable = true;
        display-messages = true;
        auto-signature-help = false;
        display-inlay-hints = false;
        snippets = true;
      };

      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
      };

      editor.file-picker = {
        hidden = false;
        follow-symlinks = true;
        deduplicate-links = true;
        parents = true;
        ignore = true;
        git-ignore = true;
        git-global = true;
        git-exclude = true;
      };

      editor.auto-save = {
        focus-lost = false;
        after-delay.enable = true;
        after-delay.timeout = 90000;
      };

      editor.search = {
        smart-case = true;
      };

      editor.soft-wrap = {
        enable = false;
        max-wrap = 25;
        wrap-at-text-width = true;
        # wrap-indicator = "";  # To hide soft-wrap indicator
      };

      editor.smart-tab = {
        enable = false;
        supersede-menu = true;
      };

      keys.normal = {
        space.q = ":q";
        space.w = ":w";
        "0" = "goto_line_start";
        "$" = "goto_line_end";
      };

      keys.insert = {
        j.k = "normal_mode";
      };
    };

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
