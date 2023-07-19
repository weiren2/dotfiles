local os = require("os")
vim.g.python3_host_prog = os.getenv('HOME') .. '/.pyenv/versions/neovim/bin/python'

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")