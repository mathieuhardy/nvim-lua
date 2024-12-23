function toggle_git_blame()
  if vim.o.filetype == 'fugitiveblame' then
    vim.cmd('close')
  else
    vim.cmd('Git blame')
  end
end
