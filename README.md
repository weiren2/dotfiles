# dotfiles

Some ~shitty~ configuration files. Not guaranteed to work 😬.

```sh
cd $HOME # Or anywhere you like
git clone https://github.com/weiren2/dotfiles.git
cd dotfiles
./setup.sh
```

Based on other scripts/tools/plugins:
- [Antidote][1] (zsh plugin manager)
- [Oh My Tmux!][2]
- [LazyVim][3] (neovim)

# Files changed
New files or symbolic links will overwrite the following files/directories. Backup if needed.
- `$HOME/.config/nvim` if neovim is installed.
- `$HOME/.config/tmux` (or `XDG_CONFIG_HOME/tmux`) will be used for installing [oh-my-tmux][2]
- `$ZSH` will be set to `$HOME/.zsh`, which is also a symbolic link to the [`zsh`](zsh) directory here.
- [Antidote][1] will be installed to `$ZSH/cache`.

# Other files
- `config/kitty`: [kitty terminal](https://sw.kovidgoyal.net/kitty/) configuration with [Catppuccin](https://github.com/catppuccin).

# Misc
Some other files or notes worth mentioning (or not...). 

## Pyenv
 - Check `pyenv`'s [installation guide](https://github.com/pyenv/pyenv#installation).
 - Also [install python build dependencies](https://github.com/pyenv/pyenv/wiki#suggested-build-environment).

[1]: https://github.com/mattmc3/antidote
[2]: https://github.com/gpakosz/.tmux
[3]: https://github.com/LazyVim/LazyVim
