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
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = "rounded",
        silent = true,
        focusable = false,
      }
    )

    vim.diagnostic.config({
      float = {
        border = "rounded",
        source = true,
        focusable = false,
        style = "minimal",
        header = "Diagnostics",
      },
    })

    require('lspconfig').ts_ls.setup({ capabilities = capabilities })
    require('lspconfig').lua_ls.setup({ capabilities = capabilities })
    require('lspconfig').elixirls.setup({ capabilities = capabilities })
  end
}
