bind " " expand-abbr or self-insert

bind ctrl-alt-d "fish_commandline_prepend cd"
bind ctrl-alt-w "fish_commandline_prepend nvim"
bind ctrl-h "commandline -f repaint; cd"

bind ctrl-shift-p "bash ~/.config/tmux/script/dev.sh"
bind ctrl-shift-b "bash ~/.config/tmux/script/config.sh"
