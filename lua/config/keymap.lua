--------------------------------------------------------------------------------
-- Bindings
--------------------------------------------------------------------------------

local telescope = require('telescope.builtin')

-- ,,: open previous file
remap('n', '<Leader><Leader>', ':e#<CR>', 'Previous file')
remap('i', '<Leader><Leader>', '<ESC>:e#<CR>', 'Previous file')
remap('v', '<Leader><Leader>', '<ESC>:e#<CR>', 'Previous file')

-- +/-: increment/decrement value under cursor
remap('n', '<kMinus>', '<Plug>nextvalDec', 'Increment/descrement')
remap('n', '<kPlus>', '<Plug>nextvalInc', 'Increment/descrement')

remap('n', '-', '<Plug>nextvalDec', 'Increment/descrement')
remap('n', '+', '<Plug>nextvalInc', 'Increment/descrement')

-- shift-v: visual block mode
remap('', '<S-v>', '<C-v>', 'Visual block mode')

-- ctrl-x: cut
remap('v', '<C-x>' ,'"+x', 'Cut')

-- ctrl-c: copy
remap('', '<C-c>' ,'"+y', 'Copy')

-- ctrl-v: paste
remap('n', '<C-v>', '"+gp', 'Paste')
remap('i', '<C-v>', '<ESC>"+gpa', 'Paste')
remap('v', '<C-v>', '"+gp', 'Paste')

-- TODO: ctrl-space: autocomplemetion

-- ctrl-b: git blame
remap('', '<C-b>', "<CMD>lua toggle_git_blame()<CR>", 'Git blame')

-- ctrl-d: delete buffers
remap('', '<C-d>', "<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>", 'Grep pattern')

-- ctrl-f: find files
remap('n', '<C-f>', "<CMD>lua require('telescope.builtin').find_files()<CR>", 'Find files')
remap('i', '<C-f>', "<ESC><CMD>lua require('telescope.builtin').find_files()<CR>", 'Find files')
remap('v', '<C-f>', "<ESC><CMD>lua require('telescope.builtin').find_files()<CR>", 'Find files')

-- ctrl-g: grep pattern
remap('n', '<C-g>', "<CMD>lua require('telescope.builtin').live_grep()<CR>", 'Grep pattern')
remap('i', '<C-g>', "<ESC><CMD>lua require('telescope.builtin').live_grep()<CR>", 'Grep pattern')
remap('v', '<C-g>', "<ESC><CMD>lua require('telescope.builtin').live_grep()<CR>", 'Grep pattern')

-- ctrl-k: comment
local commenter = require('Comment.api')

vim.keymap.set('n', '<C-k>', commenter.call('toggle.linewise.current', 'g@$'), { desc = 'Comment/uncomment', expr = true })
vim.keymap.set('v', '<C-k>', commenter.call('toggle.linewise', 'g@'), { desc = 'Comment/uncomment', expr = true })

-- ctrl-m: search manpage
remap('n', '<C-m>', "<CMD>lua require('telescope.builtin').man_pages()<CR>", 'Man pages')
remap('i', '<C-m>', "<ESC><CMD>lua require('telescope.builtin').man_pages()<CR>", 'Man pages')
remap('v', '<C-m>', "<ESC><CMD>lua require('telescope.builtin').man_pages()<CR>", 'Man pages')

-- ctrl-s: jump to definition under cursor
remap('n', '<C-s>', '<CMD>AnyJump<CR>', 'Jump to definition')
remap('i', '<C-s>', '<ESC><CMD>AnyJump<CR>', 'Jump to definition')
remap('v', '<C-s>', '<ESC><CMD>AnyJumpVisual<CR>', 'Jump to definition')

-- ctrl-t: terminal
remap('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>', 'Open terminal')
remap('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', 'Open terminal')
remap('t', '<ESC>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', 'Open terminal')

-- F1: save
remap('n', '<F1>', ':w<CR>', 'Save')
remap('i', '<F1>', '<ESC>:w<CR>a', 'Save')
remap('v', '<F1>', '<ESC>:w<CR>', 'Save')

-- F2: close
remap('n', '<F2>', ':q<CR>', 'Close')
remap('i', '<F2>', '<ESC>:q<CR>', 'Close')
remap('v', '<F2>', '<ESC>:q<CR>', 'Close')

-- F3: horizontal split
remap('n', '<F3>', ':split<CR>', 'Horizontal split')
remap('i', '<F3>', '<ESC>:split<CR>a', 'Horizontal split')
remap('v', '<F3>', '<ESC>:split<CR>', 'Horizontal split')

-- F4: vertical split
remap('n', '<F4>', ':vsplit<CR>', 'Vertical split')
remap('i', '<F4>', '<ESC>:vsplit<CR>a', 'Vertical split')
remap('v', '<F4>', '<ESC>:vsplit<CR>', 'Vertical split')

-- F7: no highlight
remap('n', '<F7>', ':nohlsearch<CR>', 'No highlight')
remap('i', '<F7>', '<ESC>:nohlsearch<CR>a', 'No highlight')
remap('v', '<F7>', '<ESC>:nohlsearch<CR>', 'No highlight')

-- F10: filesystem explorer
remap('n', '<F10>', ':Neotree toggle<CR>', 'Filesystem explorer')
remap('i', '<F10>', '<ESC>:Neotree toggle<CR>a', 'Filesystem explorer')
remap('v', '<F10>', '<ESC>:Neotree toggle<CR>', 'Filesystem explorer')

-- F11: toggle invisible chars
remap('n', '<F11>', '<CMD>lua toggle_invisible_chars()<CR>', 'Show invisible characters')
remap('i', '<F11>', '<ESC><CMD>lua toggle_invisible_chars()<CR>a', 'Show invisible characters')
remap('v', '<F11>', '<ESC><CMD>lua toggle_invisible_chars()<CR>', 'Show invisible characters')

-- F12: distraction free mode
remap('n', '<F12>', ':Goyo<CR>', 'Distraction free mode')
remap('i', '<F12>', '<ESC>:Goyo<CR>a', 'Distraction free mode')
remap('v', '<F12>', '<ESC>:Goyo<CR>', 'Distraction free mode')

-- ctrl-F12: limited view mode
remap('n', '<C-F12>', ':Limelight!!<CR>', 'Limited view mode')
remap('i', '<C-F12>', '<ESC>:Limelight!!<CR>a', 'Limited view mode')
remap('v', '<C-F12>', '<ESC>:Limelight!!<CR>', 'Limited view mode')
