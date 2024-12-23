if vim.fn.has('autocmd') then
  vim.api.nvim_create_autocmd(
    {'BufNewFile'},
    {
      pattern = '*.py',
      callback = function()
        load_template('py')
      end
    }
  )

  vim.api.nvim_create_autocmd(
    {'BufNewFile'},
    {
      pattern = '*.sh',
      callback = function()
        load_template('sh')
      end
    }
  )
end
