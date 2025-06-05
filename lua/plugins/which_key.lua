return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { 'echasnovski/mini.nvim', version = '*' },
  },
  opts = {
    win = {
      border = "double",        -- none, single, double, shadow
      title = "Keybindings",
      title_pos = "center",     -- title position: left, center, right
      padding = { 2, 4, 2, 4 }, -- [top, right, bottom, left]
      wo = {
        winblend = 0,
      }
    },
  },
  init = function()
    require("which-key").add({
      -- General
      { "<leader>q",  "<cmd>q<cr>",                                                       desc = "Exit" },
      { "<leader>e",  "<cmd>NvimTreeToggle<cr>",                                          desc = "File Explorer" },
      { "<leader>w",  "<cmd>:w<cr>",                                                      desc = "Save" },
      { "<leader>h",  "<cmd>noh<cr>",                                                     desc = "Clear search highlights" },
      -- Move line/block up/down (VSCode style)
      { "<A-j>",      "<Esc>:m .+1<CR>==gi",                                              desc = "Move line down" },
      { "<A-k>",      "<Esc>:m .-2<CR>==gi",                                              desc = "Move line up" },
      -- Window navigation
      { "<C-h>",      "<C-w>h",                                                           desc = "Window left" },
      { "<C-j>",      "<C-w>j",                                                           desc = "Window down" },
      { "<C-k>",      "<C-w>k",                                                           desc = "Window up" },
      { "<C-l>",      "<C-w>l",                                                           desc = "Window right" },
      -- Window resize
      { "<C-Up>",     ":resize -2<CR>",                                                   desc = "Resize window up" },
      { "<C-Down>",   ":resize +2<CR>",                                                   desc = "Resize window down" },
      { "<C-Left>",   ":vertical resize -2<CR>",                                          desc = "Resize window left" },
      { "<C-Right>",  ":vertical resize +2<CR>",                                          desc = "Resize window right" },
      -- QuickFix
      { "]q",         "<cmd>cnext<cr>",                                                   desc = "Next QuickFix" },
      { "[q",         "<cmd>cprev<cr>",                                                   desc = "Previous QuickFix" },
      { "<C-q>",      "<cmd>lua QuickFixToggle()<cr>",                                    desc = "Toggle QuickFix" },
      -- Search
      { "<leader>s",  group = "Search" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",                                    desc = "Find files" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                       desc = "Keymaps", },
      { "<leader>sR", "<cmd>Telescope registers<cr>",                                     desc = "Registers", },
      { "<leader>st", "<cmd>Telescope live_grep<cr>",                                     desc = "Text", },
      { "<leader>sl", "<cmd>Telescope resume<cr>",                                        desc = "Resume last search", },
      { "<leader>sp", "<cmd>Telescope colorscheme<cr>",                                   desc = "Colorscheme", },
      { "<leader>sr", "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>", desc = "Recent files", },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                                      desc = "Commands", },
      { "<leader>sT", "<cmd>lua CustomLiveGrep()<cr>",                                    desc = "Text Glob", },
      { "<leader>sb", "<cmd>Telescope buffers<cr>",                                       desc = "Buffers", },
      -- Plugins
      { "<leader>p",  group = "Plugins" },
      { "<leader>pi", "<cmd>Lazy install<cr>",                                            desc = "Install" },
      { "<leader>ps", "<cmd>Lazy sync<cr>",                                               desc = "Sync" },
      { "<leader>pS", "<cmd>Lazy clear<cr>",                                              desc = "Status" },
      { "<leader>pc", "<cmd>Lazy clean<cr>",                                              desc = "Clean" },
      { "<leader>pu", "<cmd>Lazy update<cr>",                                             desc = "Update" },
      { "<leader>pp", "<cmd>Lazy profile<cr>",                                            desc = "Profile" },
      { "<leader>pl", "<cmd>Lazy log<cr>",                                                desc = "Log" },
      { "<leader>pd", "<cmd>Lazy debug<cr>",                                              desc = "Debug" },
    })
  end
}
