return
{
  "nvim-telescope/telescope-ui-select.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  init = function()
    require("telescope").load_extension("ui-select")
  end,
}
