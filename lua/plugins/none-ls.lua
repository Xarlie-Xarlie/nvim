return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local null_ls = require('null-ls')
    return {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.code_actions.gitsigns,
        -- null_ls.builtins.diagnostics.eslint,
      }
    }
  end
}
