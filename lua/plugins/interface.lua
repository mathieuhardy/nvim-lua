return {
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        icons_enabled = false,
        component_separators = {
          left = '|',
          right = '|'
        },
        section_separators = {
          left = '',
          right = '',
        },
      }
    },
  },

  -- Scrollbar
  {
    'dstein64/nvim-scrollview',
    lazy = false,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    lazy = false,
    main = 'ibl',
    opts = {
      scope = {
        show_start = false
      }
    },
  },

  -- Distraction free mode
  {
    'junegunn/goyo.vim',
    lazy = false,
  },

  -- Limited view
  {
    'junegunn/limelight.vim',
    lazy = false,
  },

  -- Wild menu
  {
    'gelguy/wilder.nvim',
    lazy = false,
    opts = {
      modes = {':', '/', '?'}
    },
  },

  -- Highlight word under cursor
  {
    'itchyny/vim-cursorword',
    lazy = false,
  },

  -- Buffers bar
  {
    enabled = true,
    'romgrk/barbar.nvim',
    lazy = false,
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      animation = false,
    },
  },

  -- Close buffers
  {
    'kazhala/close-buffers.nvim',
    lazy = false,
  },
}
