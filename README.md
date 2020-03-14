# dotfiles

Some ~shitty~ configuration files. Not guaranteed to work 😬.

```sh
cd $HOME # Or anywhere you like
git clone https://github.com/weiren2/dotfiles.git
cd dotfiles
./setup.sh
```

Based on other scripts/tools/plugins:
- [Oh My Zsh][1]
- [Oh My Tmux!][2]
- [dein.vim][3]
- Check .vimrc for vim plugins used

# Files changed
New files or symbolic links will overwrite the following files/directories. Backup if needed.
- `$HOME/.vimrc`
- `$HOME/.config/nvim/init.vim` if neovim is installed
- `$HOME/.cache/dein` will be used for installing [dein.vim][3]
- `$HOME/.tmux` will be used for installing [oh-my-tmux][2]
- `$HOME/.oh-my-zsh` will be used for installing [oh-my-zsh][1]

[1]: https://github.com/ohmyzsh/ohmyzsh/
[2]: https://github.com/gpakosz/.tmux
[3]: https://github.com/Shougo/dein.vim

# Misc
`idleToes.terminal`: a color profile for macOS terminal.
