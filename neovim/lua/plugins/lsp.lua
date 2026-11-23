return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      require("config.lsp_sources").prefer_external(
        opts.servers
      )
    end,
  },
}
