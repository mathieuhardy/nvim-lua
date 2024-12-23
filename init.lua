--------------------------------------------------------------------------------
-- Leader
--------------------------------------------------------------------------------

vim.g.mapleader = ','
vim.g.maplocalleader = ','

--------------------------------------------------------------------------------
-- Load default use configuration files
--------------------------------------------------------------------------------

function table_merge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                table_merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

vim.cmd('luafile ' .. vim.fn.stdpath('config') .. '/lua/config/defaults.lua')
vim.cmd('silent! luafile ' .. vim.fn.stdpath('config') .. '/config.lua')

if not opts then
  opts = {}
end

global_opts = table_merge(default_opts, opts)

--------------------------------------------------------------------------------
-- Load configs
--------------------------------------------------------------------------------

require('helpers.mod')

-- Must be before other config files
require('config.lazy')

require('config.autocmds')
require('config.files')
require('config.global')
require('config.interface')
require('config.keymap')
require('config.search')
require('config.templates')
require('config.text')

-- TODO: Goyo not working well
-- TODO: telescope runs on pressing ENTER
-- TODO: enable disable wrapping with ctrl+w
-- TODO: book mode ?
