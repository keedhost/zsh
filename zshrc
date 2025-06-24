export OS=$(uname)
export BIN="$HOME/bin"

if [ $OS = "Linux" ]; then
    if command -v dpkg >/dev/null 2>&1; then
        Distro="Debian"
    elif command -v rpm >/dev/null 2>&1; then
        Distro="RedHat"
    else
        Distro="Other"
    fi
fi


[ ! -d $BIN ] && mkdir -v $BIN

# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/bin"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.zsh/oh-my-zsh"


######################### Oh My Posh declaration ###############################
## Link: https://ohmyposh.dev

function install-oh-my-posh {
    if ! command -v oh-my-posh >/dev/null 2>&1; then
        if [ $OS = "Darwin" ]; then
            brew install jandedobbeleer/oh-my-posh/oh-my-posh
        elif [ $OS = "Linux" ]; then
            wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O $BIN/oh-my-posh
            chmod +x $BIN/oh-my-posh

            ## Install themes
            mkdir ~/.poshthemes
            wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
            unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
            chmod u+rw ~/.poshthemes/*.omp.*
            rm ~/.poshthemes/themes.zip
            oh-my-posh font install Noto && echo "Install Noto Mono NERD font as default in your terminal"
        else
            echo "Unknown OS — Oh My Posh will not be installed"
        fi
    fi
}

function load-oh-my-posh {
    install-oh-my-posh

    theme="rudolfs-dark"
    if [ $OS = "Darwin" ]; then
        if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
            eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/$theme.omp.json)"
        fi
    elif [ $OS = "Linux" ]; then
        eval "$($BIN/oh-my-posh init zsh --config ~/.poshthemes/$theme.omp.json)"
    fi
}

## Do not forget install fonts:
## oh-my-posh font install
##
######################## End Oh My Posh declaration ############################


############################# FZF declaration ##################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

if command -v bat >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS='--preview="bat {}" --preview-window=right:60%:wrap'
else
    export FZF_DEFAULT_OPTS='--preview="cat {}" --preview-window=right:60%:wrap'
fi
#bindkey '^R' fzf-cdr
#bindkey '^H' fzf-history
# Use ctrl-t instead of tab key
#export ZSH_FZF_PASTE_KEY=ctrl-t

########################### End FZF declaration ################################

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cypher"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	man
	sudo
	colored-man-pages
	command-not-found
	colorize
	common-aliases
	extract
	encode64
	genpass
	pip
	rsync
	zsh-interactive-cd
	thefuck
	battery
	dirhistory
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias q="cd .."

alias v="vim"
command -v nvim >/dev/null 2>&1 && alias n="nvim"
alias httpserver="python3 -m http.server 8000"
alias git_log="git log \
    --graph \
    --pretty=oneline \
    --abbrev-commit"

alias git_clog="git log \
    --graph \
    --abbrev-commit \
    --decorate \
    --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' \
    --all"

alias sshconf="vim ~/.ssh/config"
# PROMPT="%{${fg_bold[red]}%}%n %{${fg_bold[blue]}%}[%m] $(battery_pct_prompt) %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "
load-oh-my-posh
