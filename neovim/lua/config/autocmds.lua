-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    pattern = "*",
    desc = "Set cursor shape to vertical bar on VimLeave/VimSuspend",
    callback = function()
        vim.opt.guicursor = 'a:ver25'
    end,
})
