# ____  _     _                           _ _   _         _____    _
#/ ___|| |__ (_)_ __  _   _ _______ _ __ (_) |_| |__     |__  /___| |__  _ __ ___
#\___ \| '_ \| | '_ \| | | |_  / _ \ '_ \| | __| '_ \      / // __| '_ \| '__/ __|
# ___) | | | | | | | | |_| |/ /  __/ | | | | |_| | | |  _ / /_\__ \ | | | | | (__
#|____/|_| |_|_|_| |_|\__, /___\___|_| |_|_|\__|_| |_| (_)____|___/_| |_|_|  \___|
#                     |___/

#export PROMPT="%F{078}%~"$'\n'" ❯ %f"
eval "$(starship init zsh)"
autoload -U promptinit; promptinit
autoload -U colors && colors
export PWD=/home/$USER
export OLDPWD=/home/$USER
export BAT_THEME="base16"

export KEYTIMEOUT=1
export ZSH=/usr/share/oh-my-zsh
source $ZSH/oh-my-zsh.sh
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DIRENV_LOG_FORMAT=

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.config/zsh/zsh_history
HIST_STAMPS="dd/mm/yyyy"
compinit
eval "$(zoxide init zsh)"
_comp_options+=(globdots) # lets you tab complete hidden files by default

#(cat ~/.cache/wal/sequences &)
plugins=(
	zsh-autosuggestions
	vi-mode
	zsh-syntax-highlighting
	)

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
	 [[ $1 = 'block' ]]; then
	echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
	   [[ ${KEYMAP} == viins ]] ||
	   [[ ${KEYMAP} = '' ]] ||
	   [[ $1 = 'beam' ]]; then
	echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
	bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, di{ etc..
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
	bindkey -M $m $c select-bracketed
  done
done

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^E' edit-command-line
bindkey -v 

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $ZDOTDIR/.zshrc-alias ]] && . $ZDOTDIR/.zshrc-alias
[[ -f $ZDOTDIR/fzf/completion.zsh ]] && . $ZDOTDIR/fzf/completion.zsh
[[ -f $ZDOTDIR/fzf/key-bindings.zsh ]] && . $ZDOTDIR/fzf/key-bindings.zsh
[[ ! -f ${XDG_CACHE_HOME:-${HOME}/.cache}/neofetch-cache ]] && /usr/bin/neofetch > ~/.cache/neofetch-cache
=cat ${XDG_CACHE_HOME:-${HOME}/.cache}/neofetch-cache
precmd(){print""}

# Nix stuff
. /home/aakash/.local/state/nix/profile/etc/profile.d/nix.sh
eval "$(direnv hook zsh)"
