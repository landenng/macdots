### Color Scheme Sourcing
source ~/.config/nvim/schemes/shell/yui.sh

### export path for homebrew
export PATH="/opt/homebrew/bin:$PATH"

### case insensitivity
autoload -Uz +X compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

### Zim Configuration
# use rose-pine-moon color scheme for zsh syntax highlighting
# source ~/.zim/schemes/dracula-zsh-syntax-highlighting.zsh

# use 'degit' tool by default
zstyle ':zim:zmodule' use 'degit'
ZIM_HOME=~/.zim

# install zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# initialize modules
source ${ZIM_HOME}/init.zsh

### Aliases
alias ls="ls --color=always"
alias ll="eza -l -g --icons"
alias lla="ll -a"
alias mkdir="mkdir -pv"
alias pipir="pip install --no-cache-dir -r"

### Git Aliases
alias ga='git add'
alias gc='git commit'
alias gpsh='git push'
alias gp='git pull'
alias gss='git status -s'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by `pipx` on 2024-06-02 21:41:55
export PATH="$PATH:/Users/holo/.local/bin"
