return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function(_, plugin_opts)
    require("toggleterm").setup(plugin_opts)

    function _G.set_terminal_keymaps()
      local keymap_opts = { buffer = 0 }
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], keymap_opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], keymap_opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], keymap_opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], keymap_opts)
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
  opts = {
    open_mapping = nil,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = false,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "rounded",
      winblend = 0,
    }
  }
}
