{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "gentoo";
        padding.left = 4;
        padding.right = 4;
        color = {
          "1" = "magenta";
          "2" = "white";
        };
      };

      display = {
        size.binaryPrefix = "si";
        color = "magenta";
        separator = " / ";
      };

      modules = [
        "datetime"
        "break"
        {
          type = "host";
          key = "Host";
          format = "{family}";
        }
        {
          type = "display";
          key = "Resolution";
          compactType = "original-with-refresh-rate";
        }
        {
          type = "cpu";
          key = "CPU";
          format = "{name} ({cores-physical}/{cores-logical}) @ {freq-max}";
        }
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          key = "Memory";
          percent = {
            type = 3;
            green = 30;
            yellow = 70;
          };
        }
        "disk"
        "uptime"
        # {
        #     type = "custom";
        #     format = "└{$1}───────────────────────────────────────────{$1}┘";
        # }
        "break"
        {
          type = "os";
          key = "OS";
          format = "{name} {version}";
        }
        "kernel"
        "packages"
        "terminal"
        {
          type = "font";
          key = "Font";
          format = "{font2}";
        }
        {
          type = "swap";
          key = "Swap";
          percent = {
            type = 3;
            green = 30;
            yellow = 70;
          };
        }
        # {
        #     type = "custom";
        #     format = "└{$1}─────────────────────────────────────────────────────────{$1}┘";
        # }
        "break"
        {
          type = "localip";
          key = "Local IP";
          format = "{ipv4} ({ifname}) [{mac}]";
        }
        "publicip"
        "break"
        "battery"
      ];
    };
  };
}
