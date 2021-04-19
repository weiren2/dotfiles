#!/usr/bin/env bash

CURR_DIR=$(pwd -P)
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

echo
# Install oh-my-zsh for zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	(export RUNZSH=no; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
else
	echo "Oh-my-zsh already installed!"
fi

# Use customized zsh / oh-my-zsh config
ln -sfn $CURR_DIR/.zshrc $HOME/.zshrc


echo
# Oh My Tmux config
if [[ ! -d "$HOME/.tmux" ]]; then
	cd ~
	git clone https://github.com/gpakosz/.tmux.git || true
	ln -s -f .tmux/.tmux.conf
	cp .tmux/.tmux.conf.local .
  echo "Oh-my-tmux configuration installed in $HOME/.tmux!"
else
	echo "Oh-my-tmux already installed in $HOME/.tmux!"
fi
