-- Use mouse everywhere
if vim.fn.has('mouse') then
  vim.o.mouse = 'a'
end

-- Sizes
vim.o.cmdheight = 1                             -- height of the command bar
vim.o.numberwidth = 1                           -- minimal length of numbers margin
vim.o.linespace = 0                             -- spaces between lines

-- Error notifications
vim.o.visualbell = false                        -- don't blink windows on error
vim.o.errorbells = false                        -- don't make noise

-- Offsets from current position
vim.o.scrolloff = 0                             -- offset below and above the current line
vim.o.sidescrolloff = 0                         -- number of columns between active column and cursor

-- Various
vim.o.lazyredraw = false                        -- redraw window during scripts execution
vim.o.insertmode = false                        -- don't start in insert mode
vim.o.hidden = true                             -- a buffer becomes hidden when it is abandoned
vim.o.report = 0                                -- always display messages like '1 line yanked'
vim.o.confirm = true                            -- display graphical confirmation dialogs
vim.o.number = true                             -- turn on line numbers
vim.o.backspace = 'indent,eol,start'            -- make backspace more flexible
vim.o.startofline = false                       -- leave my cursor where it was
vim.o.ruler = true                              -- always show current position in status bar
vim.o.showtabline = 1                           -- show tab widget if there's more than 1 tab
vim.o.showcmd = true                            -- show the command being typed
vim.o.whichwrap = vim.o.whichwrap .. ',<,>,h,l' -- go to next/previous line when reaching end/begin of line with cursor
vim.o.ttyfast = true                            -- fast scrolling
vim.o.paste = false                             -- allow indentation during pastes
vim.o.showmode  = false                         -- because we use lightline plugin
vim.o.laststatus = 2                            -- always show the status line

-- Buffer bar
--vim.o.guitablabel = '%t'                        -- Only filename in tab bar

-- Regex
vim.o.magic = true                              -- allow to search with regex like '.*'

-- Matching
vim.o.showmatch = true                          -- show matching brackets
vim.o.matchpairs = vim.o.matchpairs .. ',<:>'   -- add other sets of characters to match

-- Highlightning
if vim.fn.has('syntax') then
  vim.o.cursorline = false                      -- no highlight of current row
  vim.o.cursorcolumn = false                    -- no highlight of current column
  vim.o.syntax = 'on'                           -- syntax highlighting on
end

-- Wrapping
vim.o.wrap = false
