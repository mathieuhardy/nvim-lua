return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<F3>'] = 'select_horizontal',
            ['<F4>'] = 'select_vertical',
          }
        }
      }
    },
  },
}
