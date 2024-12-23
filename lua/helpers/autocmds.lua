  function autocmd_add_tab_size(group, patterns, tab_size)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = patterns,
      group = group,
      callback = function()
        vim.opt.tabstop = tab_size
        vim.opt.softtabstop = tab_size
        vim.opt.shiftwidth = tab_size
      end,
  })
  end
