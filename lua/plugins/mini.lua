return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    dependencies = {
      { 'echasnovski/mini.surround',   version = '*', init = function() require('mini.surround').setup() end },
      { 'echasnovski/mini.splitjoin',  version = '*', init = function() require('mini.splitjoin').setup() end },
      { 'echasnovski/mini.trailspace', version = '*', init = function() require('mini.trailspace').setup() end },
    },
  },
}
