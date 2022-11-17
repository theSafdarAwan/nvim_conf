local utils = require("safdar.core.utils")
local api = utils.api
local opt = utils.opt
local optl = utils.optl
local cmd = utils.cmd
local create_autocmd = api.nvim_create_autocmd

local autocmds_augroup =
api.nvim_create_augroup("autocmds.lua", { clear = true })

-- Highlight The yanked text
local function highlightOnYank()
    require("vim.highlight").on_yank({ timeout = 40 })
end

create_autocmd({ "TextYankPost" }, {
    group = autocmds_augroup,
    callback = highlightOnYank,
})

-- Help Helper Function
local function helpHelper()
    optl.relativenumber = true
    optl.number = true
    optl.conceallevel = 0
    optl.statusline = " "
    local hl = function(highlightGroup, opts)
        api.nvim_set_hl(0, highlightGroup, opts)
    end
    hl("HelpBar", { link = "Normal" })
    hl("HelpStar", { link = "Normal" })
end

-- set a bunch of options for the help filetype
create_autocmd({ "FileType" }, {
    group = autocmds_augroup,
    pattern = { "help" },
    callback = helpHelper,
})

-- Help Helper Function
local function norgFtOpts()
    optl.shiftwidth = 2
end

-- set spell forthe gitcommit messages and other filetypes
create_autocmd({ "FileType" }, {
    group = autocmds_augroup,
    pattern = { "norg" },
    callback = norgFtOpts,
})

-- Don't show the line numbers in terminal mode
local function terminalMode()
    optl.number = false
    optl.relativenumber = false
    opt.filetype = "terminal"
    optl.spell = false
end

create_autocmd({ "TermOpen" }, {
    group = autocmds_augroup,
    callback = terminalMode,
})

-- Damian Conway
create_autocmd({ "BufEnter" }, {
    group = autocmds_augroup,
    command = "call matchadd('DamianConway', '\\%80v')",
})

-- Colorizer plugin attach autocmd's
create_autocmd({ "BufEnter", "InsertLeave", "CursorMoved", "CursorHold" }, {
    group = autocmds_augroup,
    command = "ColorizerAttachToBuffer",
})

-- don't give exit code when exiting the terminal
cmd([[
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
]])