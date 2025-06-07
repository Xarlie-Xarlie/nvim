return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      require("telescope").load_extension("ui-select")
      -- require("telescope").load_extension("noice")
      require("telescope").load_extension("recent_files")
      require("telescope").load_extension("projects")
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
