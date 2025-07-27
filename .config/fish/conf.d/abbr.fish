# Folder navigation
abbr -a c "cd ~/.config/"

abbr -a ... "cd ../../"
abbr -a l "ls -al"

# Common command
abbr -a clr "clear"

abbr -a sp "sudo pacman "
abbr -a pa "pacman "

abbr -a y "yay "

abbr -a ne "nix-env "
abbr -a ns "nix-shell "

# Git
abbr -a g "git "

abbr -a gs "git status"
abbr -a gb "git branch"
abbr -a gf "git fetch"

abbr -a gc "git commit "
abbr -a gp "git push"

# Tmux
abbr -a t "tmux "

abbr -a ta "tmux attach "

abbr -a tl "tmux ls"
abbr -a tk "tmux kill-server"

# Run setup.sh
abbr -a ./setup "fd_up setup.sh | xargs bash"
