return {
  -- Colorshemes
  {
    enabled = true,
    'sainnhe/sonokai',
    lazy = false,
    init = function()
      vim.g.sonokai_style = 'default'
      vim.cmd.colorscheme('sonokai')
    end,
  },

  {
    enabled = false,
    'sainnhe/edge',
    lazy = true,
    -- opts = {
    --   style = 'warmer',
    -- },
    init = function()
      vim.g.edge_style = 'default'
      vim.cmd.colorscheme('edge')
    end,
  },

  {
    enabled = false,
    'catppuccin/nvim',
    lazy = true,
    init = function()
      vim.cmd.colorscheme('catppuccin-frappe')
    end,
  },

  -- Highlight CSS colors
  {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    init = function()
      vim.opt.termguicolors = true
    end,
    config = function()
      require('colorizer').setup()
    end,
  },
}
