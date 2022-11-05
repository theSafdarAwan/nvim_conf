local utils = require("safdar.core.utils")
local opt = utils.opt
local wo = utils.wo
local g = utils.g

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

-- Line indenting
opt.list = true
opt.listchars:append("eol:↴")
opt.listchars:append("space:⋅")

-- time to update undo file or swap file
opt.updatetime = 250

-- use either undo file or swap file
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.nvim_undodir/"
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
wo.signcolumn = "yes"
