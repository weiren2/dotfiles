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
- [LazyVim][3]
- Check .vimrc for vim plugins used

# Files changed
New files or symbolic links will overwrite the following files/directories. Backup if needed.
- `$HOME/.config/nvim` if neovim is installed.
- `$HOME/.tmux` will be used for installing [oh-my-tmux][2]
- `$HOME/.oh-my-zsh` will be used for installing [oh-my-zsh][1]

# Other files
- `config/kitty`: [kitty terminal](https://sw.kovidgoyal.net/kitty/) configuration with [Catppuccin](https://github.com/catppuccin).

# Misc
Some other files or notes worth mentioning (or not...). 
## Remove conda `(base)` in `$PS1` prompt (awkwardly)
But keep the extra prompt when in conda environments other than `base`
```sh
mkdir -p $CONDA_INSTALL_DIR/etc/conda/activate.d
```
Put a file (e.g., `remove_base_ps1.sh`) in this directory with the following line:
```sh
PS1="$(echo "$PS1" | sed 's/(base)//')"
```
Source: [How to remove (base) from terminal prompt after updating conda][4].


[1]: https://github.com/ohmyzsh/ohmyzsh/
[2]: https://github.com/gpakosz/.tmux
[3]: https://github.com/LazyVim/LazyVim
[4]: https://stackoverflow.com/a/55172508
