return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    window = {
      width = 0.4,
    },
    mappings = {
      complete = {
        insert = '<C-t>'
      },
      reset = {
        normal = "<C-r>",
        insert = "<C-r>",
      },
      close = {
        normal = "<C-c>",
        insert = "<C-c>",
      }
    },
    temperature = 0.2,
    prompts = {
      Rename = {
        prompt = "Please rename the variable correctly in the given selection based on context",
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source)
        end
      }
    }
  },
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        -- Set buffer-local options
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.conceallevel = 0
      end
    })
  end,
}
