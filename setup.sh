# vimrc (also for neovim)
wget https://gist.githubusercontent.com/weiren2/de9099a15a219b1909ac98f9469bd5d2/raw/3c46a336f9482f30fc96f5bc4c53852d59fe2519/.vimrc -O ~/.vimrc
mkdir -p ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# oh-my-zsh
(export RUNZSH=no; sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")

# Customize zsh / oh-my-zsh config 
wget "https://gist.githubusercontent.com/weiren2/de9099a15a219b1909ac98f9469bd5d2/raw/3c46a336f9482f30fc96f5bc4c53852d59fe2519/.zshrc" -O .zshrc

# Oh My Tmux config
cd ~
git clone https://github.com/gpakosz/.tmux.git || true
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# Install dein (Vim package manager)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein