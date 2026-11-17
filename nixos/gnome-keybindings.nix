{ ... }: {
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      move-to-center = ["<Super><Control>c"];
      move-to-corner-ne = ["<Super><Control><Shift>Right"];
      move-to-corner-nw = ["<Super><Control><Shift>Left"];
      move-to-corner-se = ["<Super><Control><Shift>Up"];
      move-to-corner-sw = ["<Super><Control><Shift>Down"];
      move-to-side-e = ["<Super><Control>Right"];
      move-to-side-n = ["<Super><Control>Up"];
      move-to-side-s = ["<Super><Control>Down"];
      move-to-side-w = ["<Super><Control>Left"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
    };

    "org/gnome/shell/keybindings" = {
      show-screen-recording-ui = [];
      show-screenshot-ui = ["<Shift><Control><Alt>r"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [];
      mic-mute = ["F8"];
      next = ["<Control><Super>period"];
      play = ["<Control><Super>slash"];
      previous = ["<Control><Super>comma"];
      volume-down = ["F6"];
      volume-mute = ["F5"];
      volume-up = ["F7"];
    };
  };
}
