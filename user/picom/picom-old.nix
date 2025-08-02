
{ config, pkgs, ... }:

{

  services.picom = {
    enable = true;

    package = pkgs.picom;

    backend = "glx";
    vSync = true;

    wintypes = {
      tooltip = { fade = true; shadow = false; focus = false; };
      normal = { shadow = false; };
      dock = { shadow = false; };
      dnd = { shadow = false; };
      popup_menu = { shadow = true; focus = false; opacity = 0.90; };
      dropdown_menu = { shadow = false; focus = false; };
      above = { shadow = true; };
      splash = { shadow = false; };
      utility = { focus = false; shadow = false; blur-background = false; };
      notification = { shadow = false; };
      desktop = { shadow = false; blur-background = false; };
      menu = { focus = false; };
      dialog = { shadow = true; };
    };

    fade = true;
    fadeSteps = [ 0.03 0.03 ];
    fadeDelta = 3;

    shadow = true;
    shadowOpacity = 0.75;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "class_g = 'slop'"
      "class_g = 'Firefox'"
      "class_g = 'Rofi'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];

    opacityRules = [
      "80:class_g = 'URxvt'"
      "80:class_g = 'UXTerm'"
      "80:class_g = 'XTerm'"
      "99:window_type = 'normal'"
      "99:window_type = 'dialog'"
      "99:window_type = 'popup_menu'"
      "99:window_type = 'notification'"
      "99:window_type = 'dock'"
    ];

    settings = {
    
      corner-radius = 20;

      blur = {
        method = "dual_kawase";
        strength = 7;
        size = 12;
        deviation = false;
        kernel = "11x11gaussian";
      };
      blur-background-frame = true;
      blur-background-fixed = true;

      blur-background-exclude = [
       "window_type = 'desktop'"
       "window_type = 'utility'"
       "window_type = 'notification'"
       "class_g = 'slop'"
       "class_g = 'Firefox'"
       "name = 'Rofi'"
       "_GTK_FRAME_EXTENTS@:c"
      ];

      shadow-color = "#000000";
      shadow-radius = 12;
      shadow-offset-x = -12;
      shadow-offset-y = -12;

      no-fading-openclose = true;
      no-fading-destroyed-argb = true;

      frame-opacity = 1.0;

      use-damage = true;

      detect-client-opacity = true;
      detect-client-leader = true;
      detect-transient = true;

    };
  };
}
