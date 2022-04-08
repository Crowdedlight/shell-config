# Setup fzf
# ---------
if [[ ! "$PATH" == */home/fm/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/fm/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/doc/fzf/examples/key-bindings.zsh"
