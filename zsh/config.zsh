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

setopt AUTO_CD

bindkey -e
