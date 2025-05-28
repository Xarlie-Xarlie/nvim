return {
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugin-config.comment")
    end
  }
}
