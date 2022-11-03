local vim = vim
local opt = vim.opt
local optl = vim.opt_local
local api = vim.api

-- Highlight The yanked text
local function highlightOnYank()
    require("vim.highlight").on_yank({ timeout = 40 })
end

api.nvim_create_autocmd({ "TextYankPost" }, {
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
api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "NeogitCommitMessage", "markdown", "tex", "norg" },
    command = "setlocal spell",
})

-- set a bunch of options for the help filetype
api.nvim_create_autocmd({ "FileType" }, {
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

api.nvim_create_autocmd({ "TermOpen" }, {
    callback = terminalMode,
})

-- Damian Conway
api.nvim_create_autocmd({ "BufEnter" }, {
    command = "call matchadd('DamianConway', '\\%80v')",
})

-- Colorizer plugin attach autocmd's
api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorMoved" }, {
    command = "ColorizerAttachToBuffer",
})
