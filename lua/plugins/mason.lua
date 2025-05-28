return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("plugin-config.mason")
    end
  }
}
