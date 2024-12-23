local backup_dir = vim.fn.stdpath('config') .. '/backup'
local undo_dir = vim.fn.stdpath('config') .. '/undo'

-- File format
vim.o.fileformats = 'unix,dos,mac'  -- support all three, in this order
vim.o.encoding = 'utf-8'            -- Encoding

-- Automatic tasks
vim.o.autoread = true               -- set to auto read when a file is changed from the outside
vim.o.autowrite = false             -- no automatic writing
vim.o.autowriteall = false          -- no automatic writing
vim.o.swapfile = false              -- turn off swap files

-- Backups
vim.o.backup = true                 -- enable backup
vim.o.writebackup = true            -- backup when writing
vim.o.backupext = '.backup'         -- extension of backup files
vim.o.backupdir = backup_dir        -- directory of backup files

-- Undo
vim.o.undolevels = 1000             -- undo levels

-- Persistent undo
if vim.fn.has('persistent_undo') then
  vim.o.undodir = undo_dir        -- set directory
  vim.o.undofile = true           -- enable undo files
end
