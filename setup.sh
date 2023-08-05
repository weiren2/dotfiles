#!/usr/bin/env bash
set -e
CURR_DIR=$(pwd -P)

###### Utility Functions ######
function program_path {
	local _program=$1
	if type -p $_program &> /dev/null; then
		echo $(type -p $_program)
	fi
}

function find_program {
	local _program=$1
	printf "Trying to find $_program. "
	local _path=$(program_path $_program)
	if [ -z "$_path" ]; then
		printf "Not found! Please install $_program first.\n"
		exit 1
	else
		printf "Found at path: $_path\n"
	fi
}

function download_or_update_repo {
	local destination_dir=$1
	local git_repo_url=$2
	if [[ ! -d $destination_dir ]]; then
		git clone --depth=1 $git_repo_url $destination_dir
	else
		git -C $destination_dir pull
	fi
}

###### Prerequisites ######
find_program git
find_program curl
find_program readlink
find_program zsh
find_program starship
find_program tmux
find_program nvim
find_program npm # for LazyVim

###### Make sure `.config` directory exists ######
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
[[ -e "$CONFIG" ]] || mkdir -p "$CONFIG"


###### Custom Zsh Config ######
echo
if [[ -e "$HOME/.zsh" && (`readlink -f "$HOME/.zsh"` != "$CURR_DIR/zsh") ]]; then
	echo "Trying to symlink \`$HOME/.zsh\` but it already exists (and does not link to zsh in this repo). Abort!"
	exit 1
fi 
echo "Zsh configuration linked to directory \`$HOME/.zsh\`"
ln -sfn "$CURR_DIR/zsh" "$HOME/.zsh"

echo "\`$HOME/.zsh/.zshrc\` linked to \`$HOME/.zshrc\`"
ln -sfn "$HOME/.zsh/.zshrc" "$HOME/.zshrc"


###### Oh My Tmux config ######
echo
TMUX_OMT_DIR="$CONFIG/tmux"
TMUX_OMT_GIT="https://github.com/gpakosz/.tmux.git"

if [[ ! -d "$TMUX_OMT_DIR" ]]; then
	echo "Oh-my-tmux configuration will be installed in $TMUX_OMT_DIR!"
else 
	echo "Oh-my-tmux already installed in $TMUX_OMT_DIR! Updating it now."
fi
# Oh My Tmux provides some sane defaults. Update local config as well.
download_or_update_repo "$TMUX_OMT_DIR" "$TMUX_OMT_GIT"
ln -sfn "$TMUX_OMT_DIR/.tmux.conf" "$TMUX_OMT_DIR/tmux.conf"
# Update local Oh My Tmux local config. Backup previous one if necessary.
TMUX_OMT_LOCAL_CONF="$TMUX_OMT_DIR/tmux.conf.local"
if [[ -f "$TMUX_OMT_LOCAL_CONF" ]]; then
	mv "$TMUX_OMT_LOCAL_CONF" "$TMUX_OMT_LOCAL_CONF.backup"
fi
cp "$TMUX_OMT_DIR/.tmux.conf.local" "$TMUX_OMT_LOCAL_CONF"


# Neovim
# Check for neovim config file
NVIM_CONFIG_PATH="$CONFIG/nvim"
if [[ -d "$NVIM_CONFIG_PATH" ]]; then
	echo "Neovim config already exists! Abort."
	echo "Did not overwrite any Neovim config."
	exit 0
else
	if [[ ! -d "$CONFIG" ]]; then
		mkdir -p "$CONFIG"
	fi
	ln -sfn "$CURR_DIR/neovim" "$NVIM_CONFIG_PATH"
	echo "Neovim config linked to $NVIM_CONFIG_PATH."
fi