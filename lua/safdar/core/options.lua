local vim = vim
local opt = vim.opt
local optl = vim.opt_local
local g = vim.g
local api = vim.api

g.mapleader = " "
g.localleader = ","

-- disable the default filetype detenction
-- g.did_load_filetypes = 1

-- enable mouse
-- opt.mouse = "a"
-- disable mouse
opt.mouse = ""
opt.laststatus = 3 -- to have a global status line

-- Spell Checking lang
opt.spelllang = "en,cjk"
opt.spelloptions:append("noplainbuffer,camel")
opt.spell = false

-- set the terminal
opt.shell = "/bin/zsh"
opt.termguicolors = true

opt.wrap = false
opt.scrolloff = 2
opt.showmode = false
opt.wrap = false
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- folding
opt.foldmethod = "marker"
opt.foldmarker = "++>,<++"
-- vim.cmd([[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- ]])

-- finding files - search down into subfolders
opt.path:append({ "**" })

-- Hide the tilde sign in the blank line
opt.fillchars = { eob = " " }

opt.undofile = true
opt.updatetime = 500
opt.undodir = os.getenv("HOME") .. "/.nvim_undodir/"

-- no swap file i use undofile
opt.swapfile = false
-- trick to solve the vim compatible functionality to not let backspace the file
-- content othe then just inserted one
-- opt.backspace = nil

opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true

opt.cursorline = false

opt.cmdheight = 1
opt.timeoutlen = 500
-- line numbers
opt.number = true
opt.relativenumber = true

opt.wildoptions = "pum"
opt.winblend = 0
opt.pumblend = 0
opt.pumheight = 16

-- Indenline
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.textwidth = 81
opt.softtabstop = 4
opt.smartindent = true
opt.expandtab = true

-- opt.shortmess:append("c")
-- opt.isfname:append("@-@")

-- opt.whichwrap="<>hl"
-- opt.autochdir = true

-- sets the column on the left side (or before) of the line numbers
vim.wo.signcolumn = "yes"

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

vim.cmd([[
" Open a file from its last left off positions
" TODO: what is wrong with this line of code
" au BufReadPost * if expand('%:p') !~# 'm/.git/' && line("'"") > 1 && line("'"") <= line("$") | exe "normal! g'"" | endif 
]])

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

-- Neorg todo list popup :TODO: figure this out
function CreateNeorgTodoPop()
    vim.cmd [[highlight PopupColor1 ctermbg=lightblue guibg=lightblue]]
vim.cmd [[highlight PopupColor2 ctermbg=lightcyan guibg=lightcyan]]
    local popup = require('popup')
    popup.create(
        {""},
        {
            line = 1,
            col = 3,
            border = {3, 3, 3, 3},
            minheight = 30,
            minwidth = 80,
        })
end

-- -- Resize the Neorg Toc Split Buffer
-- local function neorgSplitTocResizer()
--     api.nvim_win_set_width(0, 20)
-- end
-- api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = "neorg://norg/Neorg Toc.norg",
--     callback = neorgSplitTocResizer,
-- })

-- =====================================================
--                   Remove Built Plugins
-- =====================================================
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
