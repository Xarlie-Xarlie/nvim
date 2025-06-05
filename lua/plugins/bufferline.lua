return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  init = function()
    require('bufferline').setup(
      {
        options = {
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              highlight = "PanelHeading",
              padding = 1,
            },
            {
              filetype = "lazy",
              text = "Lazy",
              highlight = "PanelHeading",
              padding = 1,
            },
          },
          hover = {
            enabled = true, -- requires nvim 0.8+
            delay = 200,
            reveal = { "close" },
          },
        },
      }
    )
  end,
}
