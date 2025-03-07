# Setup fzf
# ---------
if [[ ! "$PATH" == */home/fm/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/fm/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/fm/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/doc/fzf/examples/key-bindings.bash"
