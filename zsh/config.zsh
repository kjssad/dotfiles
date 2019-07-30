setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

setopt COMPLETE_ALIASES

bindkey '^[b' backward-word
bindkey '^B' backward-char
bindkey '^[f' forward-word
bindkey '^F' forward-char
bindkey '^[e' beginning-of-line
bindkey '^E' end-of-line
bindkey '^D' delete-char
bindkey '^[d' delete-word
