-- Indentation
if vim.fn.has('smartindent') then
  vim.o.smartindent = false    -- don't use stupid 'smart indentation'
end

vim.o.cino = vim.o.cino .. '(0'  -- align multiline parameters of a function
vim.o.cino = vim.o.cino .. '=0'  -- align 'break' under the 'case' statement

-- Indentation size
vim.o.tabstop = 4                -- tabulation size in display (in number of spaces)
vim.o.softtabstop = 4            -- mixed tabulation size
vim.o.shiftwidth = 4             -- size of tabulation in number of spaces
vim.o.smarttab = true            -- be smart when using tabs
vim.o.expandtab = true           -- use spaces instead of tabs
vim.o.cindent = true             -- C identation

-- Set replacements (tab, nbsp, trailing spaces)
vim.o.listchars = 'tab:▸ ,nbsp:␣,trail:-,eol:↵'

-- Text
vim.o.conceallevel = 0           -- show `` characters

-------------------------------------------------------------------------------
-- Invisible characters
-------------------------------------------------------------------------------

init_invisible_chars()
