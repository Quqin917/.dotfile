{ pkgs, ... }:
let
  themeName = "Catppuccin Mocha";
in
{
  programs.fish = {
    enable = true;
  
    interactiveShellInit = ''
      bind ctrl-alt-d "fish_commandline_prepend cd"
      bind ctrl-alt-w "fish_commandline_prepend nvim"
      bind ctrl-h "commandline -f repaint; cd"
    '';
    # bind ctrl-shift-p "bash ~/.config/tmux/script/dev.sh"
    # bind ctrl-shift-b "bash ~/.config/tmux/script/config.sh"

    shellInit = ''
      set fish_greeting

      fish_config theme choose "${themeName}"
    '';
  
    shellAbbrs = {
      g = "git";
      gc = "git commit -m";
  
      t = "tmux";
      ta = "tmux attach";
    };
  
    shellAliases = {
      # Folder navigation
      "..." = "cd ../..";
      l = "ls -al";
  
      # Common
      clr = "clear";

      nixtest = "sudo nixos-rebuild test --flake";
      nixswitch = "sudo nixos-rebuild switch --flake";
  
      # Git
      gs = "git status";
      gb = "git branch";
      gf = "git fetch";
      gp = "git push";
      gl = "git log";
      ga = "git add";
  
      # Tmux
      tl = "tmux ls";
      tk = "tmux kill-server";
    };
  };

  xdg.configFile."fish/themes" = {
    recursive = true;
    source = ./themes;
  };
}
