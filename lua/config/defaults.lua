default_opts = {
  history = 1000,
  default_max_length = 80,
  max_lengths = {
    {length = 100, filetypes = {'rust'}},
  },
  strip_whitespaces = {'*.c', '*.cpp', '*.h', '*.hpp', '*.lua', '*.py', '*.rs', '*.toml'},
  tab_sizes = {
    {size = 2, filetypes = {'lua', 'python', 'toml'}},
    {size = 4, filetypes = {'c', 'cpp', 'h', 'hpp', 'rust'}},
  },
}
