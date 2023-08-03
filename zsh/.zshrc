### Define directory for zsh configuration files
export ZSH=$HOME/.zsh
ZSH_CACHE_DIR=$ZSH/cache

### Load custom functions & fix-ups
source $ZSH/custom/functions.zsh
source $ZSH/custom/omz-plugins-fix.zsh

autoload -Uz compinit
compinit

### Plugins
ANTIDOTE=$ZSH_CACHE_DIR/antidote
[[ -e $ANTIDOTE ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE
# Setup directory for downloading plugins
ANTIDOTE_HOME=$ANTIDOTE/.plugins
# Load antidote plugin manager
source $ANTIDOTE/antidote.zsh
antidote load $ZSH/.zsh_plugins.txt

### Customize key bindings
source $ZSH/custom/key-bindings.zsh
source $ZSH/custom/nvim-editor.zsh

### .zshrc.local contains machine-specific configurations
if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi

# Persistent rehash
zstyle ':completion:*' rehash true

# Starship prompt
eval "$(starship init zsh)"