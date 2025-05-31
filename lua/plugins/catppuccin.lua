return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      functions = { "bold" },
      keywords = { "bold" },
      strings = { "italic" },
      variables = {},
    },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
