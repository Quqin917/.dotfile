{ pkgs, config, lib, ... }:

{
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;
    extraConfig = "custom.conf";

    font = {
      name = "JetBrainsMono Nerd Font";
    };

    settings = {
      # Bell
      enable_audio_bell = false;
      
      # Scrollback
      scrollback_lines = 10000;
      wheel_scroll_multiplier = 5.0;
      
      # Mouse
      click_interval = 0.5;
      mouse_hide_wait = -1;
      focus_follows_mouse = false;
      
      # Cursor
      cursor_shape = "underline";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      
      # Window
      remember_window_size = false;
      initial_window_width = 700;
      initial_window_height = 400;
      window_border_width = 0;
      window_margin_width = 12.0;
      window_padding_width = 10;
      inactive_text_alpha = 1.0;
      background_opacity = 0.40;
      placement_strategy = "center";
      hide_window_decorations = true;
      
      # Performance
      repaint_delay = 20;
      input_delay = 2;
      sync_to_monitor = false;
      
      # Tabs
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_margin_width = 0.0;
      tab_separator = " ┇ ";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
   };
  };
}
