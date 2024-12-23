return {
  -- Tree parser
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          'bash',
          'c',
          'cmake',
          'cpp',
          'css',
          'csv',
          'dockerfile',
          'helm',
          'html',
          'javascript',
          'json',
          'lua',
          'python',
          'rust',
          'sql',
          'terraform',
          'toml',
          'typescript',
          'vim',
          'vimdoc',
          'xml',
          'yaml',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}
