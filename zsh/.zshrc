# Prompt
autoload -U colors && colors
autoload -U select-word-style
select-word-style bash

export WORDCHARS='.-'
setopt promptsubst
# %F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %#
PROMPT='%F{green}%n%f %F{blue}%25<...<%~%<<%b%f %# '
RPROMPT='[%F{yellow}%?%f]'

. /etc/profile

# Ctrl+Left and Ctrl+Right for word navigation
bindkey -e
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

## === Arch-specific ===

function paclist() {
    LC_ALL=C pacman -Qei $(pacman -Qu | cut -d " " -f 1) | \
    awk 'BEGIN {FS=":"} /^Name/{printf("\033[1;36m%s\033[1;37m", $2)} /^Description/{print $2}'
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Path
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm-global/bin"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$PATH:$HOME/scripts"
PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
PATH="$PATH:$HOME/.emacs.d/bin"
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.deno/bin"
PATH="$PATH:$HOME/Android/Sdk/build-tools/30.0.2"
#PATH="$PATH:$(stack path --bin-path 2> /dev/null):$PATH"
#PATH=$(stack path --bin-path 2> /dev/null)
PATH="/home/hrishi/.stack/snapshots/x86_64-linux-tinfo6/efffecca56fd5a794090251093b3975747dc0dd1566420a63e4dc914d35a21d0/8.8.4/bin:/home/hrishi/.stack/compiler-tools/x86_64-linux-tinfo6/ghc-8.8.4/bin:/home/hrishi/.stack/programs/x86_64-linux/ghc-tinfo6-8.8.4/bin:$PATH"
export PATH

eval "$(pyenv init -)"

# Vars
export GEM_HOME=$HOME/.gem
export EDITOR="nvim"
export BROWSER="chromium"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E .git -E node_modules -E target -E cmake-build-debug -E CMakeFiles"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hrishi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hrishi/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hrishi/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hrishi/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

# zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions

zinit light zdharma/history-search-multi-word
zinit light zdharma/zui
zinit ice from"gh-r" as"program";
#zinit light junegunn/fzf-bin
zinit ice atinit"zicompinit; zicdreplay"
zinit light zdharma/fast-syntax-highlighting
zinit snippet OMZL::git.zsh
zinit snippet OMZL::theme-and-appearance.zsh
# zinit ice atload"unalias grv"
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::cp
zinit snippet OMZP::systemd
zinit snippet OMZP::fzf
zinit snippet OMZP::git
zinit snippet PZT::modules/utility/init.zsh
#zinit load lukechilds/zsh-nvm

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv

### End of Zinit's installer chunk

fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

function casm() {
    yasm -g dwarf2 -f elf64 $1.asm -l $1.lst
    ld -g -o $1 $1.o
}

