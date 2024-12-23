  function load_template(type)
    local templates_dir = vim.fn.stdpath('config') .. '/templates'

    -- Open template file
    vim.cmd('silent! 0r ' .. templates_dir .. '/skeleton.' .. type)

    -- Place cursor at the end
    vim.cmd('normal! G')
  end
