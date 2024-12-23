return {
  -- Commenter
  {
    'numToStr/Comment.nvim',
    lazy = false,
  },

  -- Autopair
  {
    'm4xshen/autoclose.nvim',
    lazy = false,
    main = 'autoclose',
    opts = {
      options = {
        disabled_filetypes = { 'text' },
        disable_when_touch = true,
        touch_regex = '[%w(%[{]',
        pair_spaces = true,
        auto_indent = true,
        disable_command_mode = true,
      },
    },
  },

  -- Open file at position
  {
     'vim-scripts/file-line',
     lazy = false,
  },

  -- Increment/decrement
  {
    'qwertologe/nextval.vim',
    lazy = false,
  },

  -- Remove trailing whitespaces
  {
    'ntpeters/vim-better-whitespace',
    lazy = false,
  }
}
