#!/usr/bin/env bash
CURR_DIR=$(pwd -P)

###### Utility Functions ######
function download_or_update_repo {
	local destination_dir=$1
	local git_repo_url=$2
	if [[ ! -d $destination_dir ]]; then
		git clone $git_repo_url $destination_dir
	else
		git -C $destination_dir pull
	fi
}

###### Neovim & Vim ######
NVIM_EXISTS=no
# Check if nvim exists
if nvim_loc="$(type -p nvim)" && [[ -n $nvim_loc ]]; then
	NVIM_EXISTS=yes
fi

# Soft link .vimrc for VIM
ln -sfn $CURR_DIR/.vimrc $HOME/.vimrc
echo "Vim config $HOME/.vimrc linked to $CURR_DIR/.vimrc."

echo
# Install dein (Vim package manager)
if [[ ! -d "$HOME/.cache/dein" ]]; then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.cache/dein
else
  echo "dein already installed!"
fi
echo "dein installed to $HOME/.cache/dein."

# Soft link init.vim for NEOVIM if it exists
if [[ $NVIM_EXISTS = yes ]]; then
	# Check for neovim config file
	if [[ ! -d "$HOME/.config/nvim" ]]; then
		mkdir -p $HOME/.config/nvim
	fi
	ln -sfn $CURR_DIR/.vimrc $HOME/.config/nvim/init.vim
	echo "Neovim config $HOME/.config/nvim/init.vim linked to $CURR_DIR/.vimrc."
else
	echo "Neovim does not exist! Skipping..."
fi

###### Oh My Zsh & Config ######
echo
# Install oh-my-zsh for zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	(export RUNZSH=no; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
else
	echo "Oh-my-zsh already installed!"
fi

OMZ_CUSTOM_PLUGIN_DIR="$CURR_DIR/omz-custom/plugins"

ZSH_SYNTAX_HIGHLIGHT_DIR="$OMZ_CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting"
ZSH_SYNTAX_HIGHLIGHT_GIT_REPO="https://github.com/zsh-users/zsh-syntax-highlighting.git"
download_or_update_repo $ZSH_SYNTAX_HIGHLIGHT_DIR $ZSH_SYNTAX_HIGHLIGHT_GIT_REPO

# Use customized zsh / oh-my-zsh config
ln -sfn $CURR_DIR/.zshrc $HOME/.zshrc


###### Oh My Tmux config ######
echo
TMUX_OMT_DIR="$HOME/.tmux"
if [[ ! -d $TMUX_OMT_DIR ]]; then
	cd ~
	git clone https://github.com/gpakosz/.tmux.git || true
	ln -s -f .tmux/.tmux.conf
  echo "Oh-my-tmux configuration installed in $TMUX_OMT_DIR!"
else
	echo "Oh-my-tmux already installed in $TMUX_OMT_DIR! Updating it now."
	git -C $TMUX_OMT_DIR pull
	# Oh My Tmux provides some sane defaults. Update local config as well.
fi

# Update local Oh My Tmux local config. Backup previous one if necessary.
TMUX_OMT_LOCAL_CONF="$HOME/.tmux.conf.local"
if [[ -f $TMUX_OMT_LOCAL_CONF ]]; then
	mv "$TMUX_OMT_LOCAL_CONF" "$TMUX_OMT_LOCAL_CONF.backup"
fi
cp $TMUX_OMT_DIR/.tmux.conf.local $TMUX_OMT_LOCAL_CONF