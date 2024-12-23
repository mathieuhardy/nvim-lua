local max_lengths = {}

function init_invisible_chars()
  vim.g.ic_enabled = 0

  if global_opts.max_lengths then
    for i, entry in pairs(global_opts.max_lengths) do
      for i, filetype in pairs(entry.filetypes) do
        max_lengths[filetype] = entry.length
      end
    end
  end
end

function toggle_invisible_chars()
  if vim.g.ic_enabled then
    vim.o.list = true

    if max_lengths[vim.bo.filetype] ~= nil then
      vim.o.colorcolumn = tostring(max_lengths[vim.bo.filetype] + 1)
    else
      vim.o.colorcolumn = tostring(global_opts.default_max_length + 1)
    end

    vim.g.ic_enabled = false
  else
    vim.o.list = false
    vim.o.colorcolumn = ''
    vim.g.ic_enabled = true
  end
end
