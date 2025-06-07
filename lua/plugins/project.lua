return {
  'ahmedkhalf/project.nvim',
  init = function()
    require("telescope").load_extension("projects")
  end
}
