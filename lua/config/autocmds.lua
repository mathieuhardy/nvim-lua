if vim.fn.has('autocmd') then
  local generalSettingsGroup = vim.api.nvim_create_augroup('General settings', { clear = true })
  local UpdatePlugs = vim.api.nvim_create_augroup("UpdateRemotePlugs", {})

  -- Strip white spaces
  vim.api.nvim_create_autocmd(
    {'BufWrite'},
    {
      pattern = global_opts.strip_whitespaces,
      callback = function()
        vim.cmd('StripWhitespace')
      end
    }
  )

  -- Set executable
  vim.api.nvim_create_autocmd(
    {'BufWritePost'},
    {
      pattern = {'*'},
      callback = function()
        if starts_with(vim.fn.getline(1), '#!') then
          vim.cmd('silent !chmod a+x <afile>')
        end
      end
    }
  )

  -- Tab sizes according to filetypes
  if global_opts.tab_sizes then
    for i, entry in pairs(global_opts.tab_sizes) do
      autocmd_add_tab_size(generalSettingsGroup, entry.filetypes, entry.size)
    end
  end

  -- Trick for wilder plugin
  vim.api.nvim_create_autocmd(
    {'VimEnter'},
    {
      pattern = "*",
      group = UpdatePlugs,
      command = "silent! UpdateRemotePlugins",
    }
  )
end
