local utils = require("safdar.core.utils")
local api = utils.api
local opt = utils.opt
local optl = utils.optl
local create_autocmd = api.nvim_create_autocmd

-- Highlight The yanked text
local function highlightOnYank()
    require("vim.highlight").on_yank({ timeout = 40 })
end

create_autocmd({ "TextYankPost" }, {
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

-- set spell forthe gitcommit messages and other filetypes
create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "NeogitCommitMessage", "markdown", "tex", "norg" },
    command = "setlocal spell",
})

-- set a bunch of options for the help filetype
create_autocmd({ "FileType" }, {
    pattern = { "help" },
    callback = helpHelper,
})

-- Don't show the line numbers in terminal mode
local function terminalMode()
    optl.number = false
    optl.relativenumber = false
    opt.filetype = "terminal"
    optl.spell = false
end

create_autocmd({ "TermOpen" }, {
    callback = terminalMode,
})

-- Damian Conway
create_autocmd({ "BufEnter" }, {
    command = "call matchadd('DamianConway', '\\%80v')",
})

-- Colorizer plugin attach autocmd's
create_autocmd({ "BufEnter", "InsertLeave", "CursorMoved" }, {
    command = "ColorizerAttachToBuffer",
})
