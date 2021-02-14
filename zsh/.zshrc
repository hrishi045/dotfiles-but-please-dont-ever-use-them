# Prompt
autoload -U colors && colors
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
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

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
### End of Zinit's installer chunk

# ZINIT SETUP START

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zinit light direnv/direnv

# ZINIT SETUP END

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

