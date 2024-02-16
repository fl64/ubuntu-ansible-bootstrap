# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/user/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
    fzf
    git
    # ansible
    kubectl
    docker
    direnv
    vagrant
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-kubectl-prompt
    terraform
    tmux
    )


POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext status time ssh)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

export PATH=$PATH:~/.local/bin


source $ZSH/oh-my-zsh.sh
#source ~/.zshrc_my
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

setopt +o nomatch

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/mc mc
complete -o nospace -C /usr/local/bin/mc mc

# aliases ======================================================

# other
alias cls="clear"
alias ls="exa"
alias cats='highlight -O ansi --force'
alias bat='bat -p --theme gruvbox-dark'

# docker
alias dcu="docker-compose up -d --build"
alias dcd="docker-compose down"
alias dcl="docker-compose logs"

# vagrant
alias vd="vagrant destroy"
alias vdf="vagrant destroy -f"
alias vu="vagrant up --provision"
alias vs="vagrant ssh"

# terraform
alias tfp="terraform plan -no-color | grep -E '(^.*[#~+-] .*|^[[:punct:]]|Plan)'"

# d8 logs
alias d8l="stern -n d8-system -l app=deckhouse -o json | jq -c .message -r | jq -R 'try fromjson catch . | del(.\"task.id\", .\"event.id\") | select(.msg|test(\"deprecated\")|not)' -c --sort-keys"
alias d8l0="stern -n d8-system -l app=deckhouse -o json --tail=0 | jq -c .message -r | jq -R 'try fromjson catch . | del(.\"task.id\", .\"event.id\") | select(.msg|test(\"deprecated\")|not)' -c --sort-keys"
alias d8lw="stern -n d8-system -l app=deckhouse -o json --tail=0 | jq -c .message -r | jq -R 'try fromjson catch . | del(.\"task.id\", .\"event.id\") | select(.level|test(\"info\")|not)' --sort-keys"

# virtualization logs
alias dvpd8="stern -n d8-system -l app=deckhouse -o json --tail=0 --include=\"virt\" | jq -c .message -r | jq -R 'try fromjson catch . | del(.\"task.id\", .\"event.id\") | select(.level|test(\"info\")|not)' --sort-keys"
alias dvpl="stern -n d8-virtualization --tail=0 . --exclude virt-api"

# d8
alias d8_edit_dh_cm="kubectl -n d8-system edit cm deckhouse"
alias d8_get_dh_image="kubectl -n d8-system get pods -l app=deckhouse -o json | jq '.items[].status.containerStatuses[] | select(.name=\"deckhouse\") | { image, imageID }'"
alias d8_node_ext_ip="kubectl get nodes -o json | jq '.items[] |  select (.status.addresses[].type==\"ExternalIP\") | { ext_ip: .status.addresses | .[] | select (.type==\"ExternalIP\") | .address, name: .metadata.name}' -r "

# d8 cilium
alias d8_edit_cilium_cm="kubectl edit cm -n d8-cni-cilium cilium-config"
alias d8_cilium_logs="stern -n d8-cni-cilium -l app=agent"
alias d8_get_cilium_ver="kubectl -n d8-cni-cilium exec -it ds/agent -c cilium-agent -- cilium version"
alias d8_hubble_port_forward="kubectl port-forward -n d8-cni-cilium svc/hubble-relay 4245:443 &"

# d8 sds-drbd
alias linstor='kubectl -n d8-sds-drbd exec -ti deploy/linstor-controller -- originallinstor'

# funcs ======================================================

function d8_set_dh_image () {
    kubectl -n d8-system set image deploy/deckhouse deckhouse="dev-registry.deckhouse.io/sys/deckhouse-oss:$1"
}

ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
function ssh () {/usr/bin/ssh -t $@ "tmux attach || tmux new";}

# generate QR code for input
function generateqr () { printf "$@" | curl -F-=\<- qrenco.de }

# get a list of files in the current folder and subfolders which contains the word “text”, the line number, and the line contact inside “less”
function ftext () { grep -iIHrn --color=always "$1" . | less -R -r }

# =============================================================

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export EDITOR="hx"


# FL
eval $( keychain --eval -q )
/usr/bin/keychain --inherit any --confirm $HOME/.ssh/id_rsa
/usr/bin/keychain --inherit any --confirm $HOME/.ssh/tfadm-id-rsa

export PATH="${PATH}:/home/user/bin"

#. <(istioctl completion zsh)

#. <(kubespy completion zsh)

. <(kubebuilder completion zsh)

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/user/yandex-cloud/path.bash.inc' ]; then source '/home/user/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/user/yandex-cloud/completion.zsh.inc' ]; then source '/home/user/yandex-cloud/completion.zsh.inc'; fi
[[ "$PATH" == *"$HOME/bin:"* ]] || export PATH="$HOME/bin:$PATH"
! { which werf | grep -qsE "^/home/user/.trdl/"; } && [[ -x "$HOME/bin/trdl" ]] && source $("$HOME/bin/trdl" use werf "1.2" "stable")

source ~/.zshrc_my
