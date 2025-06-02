return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  init = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "markdown", "markdown_inline", "python",
        "javascript", "typescript", "html",
        "css", "bash", "json", "yaml", "go",
        "rust", "java", "cpp", "elixir"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
    }
  end,
}
