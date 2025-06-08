return {
  'tamago324/nlsp-settings.nvim',
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        {
          "SmiteshP/nvim-navbuddy",
          dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
          },
          opts = { lsp = { auto_attach = true } }
        }
      },
    },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  init = function()
    require('lspconfig').tsserver.setup({})
    require('lspconfig').lua_ls.setup {}
    -- require('lspconfig').elixirls.setup {}
  end
}
