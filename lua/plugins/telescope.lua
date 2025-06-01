vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sR", "<cmd>Telescope registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope live_grep<cr>", { desc = "Text" })
vim.keymap.set("n", "<leader>sl", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })
vim.keymap.set("n", "<leader>sp", "<cmd>Telescope colorscheme<cr>", { desc = "colorscheme" })
vim.keymap.set("n", "<Leader>sr", "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>",
  { desc = "Recent files" })
vim.keymap.set("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sT", "<cmd>lua CustomLiveGrep()<cr>", { desc = "Symbols" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "Symbols" })

-- Custom Live Grep
function CustomLiveGrep()
  local include_glob = vim.fn.input("Include Glob (e.g., '*.ex* *.lock*'): ")
  local exclude_glob = vim.fn.input("Exclude Glob (e.g., '*.exs* *.tmp*'): ")
  local glob_pattern = {}

  for pattern in include_glob:gmatch("%S+") do
    table.insert(glob_pattern, pattern)
  end

  for pattern in exclude_glob:gmatch("%S+") do
    table.insert(glob_pattern, "!" .. pattern)
  end
  print("Glob Pattern: " .. vim.inspect(glob_pattern))

  require("telescope.builtin").live_grep({ glob_pattern = glob_pattern })
end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      require("telescope").load_extension("ui-select")
      -- require("telescope").load_extension("noice")
      require("telescope").load_extension("recent_files")
    end,
    opts = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({})
      },
      ["noice"] = {
        require("telescope.themes").get_dropdown({})
      },
    }
  }
}
