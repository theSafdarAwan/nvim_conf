local opt = vim.opt
local window_option = vim.wo
local option = vim.o
local global = vim.g

global.mapleader = " "
global.localleader = " "

opt.mouse = "" -- disable mouse
opt.laststatus = 3 -- to have a global status line

opt.updatetime = 1000 -- time for updating {undo, swap}file and a few other things.

opt.undofile = true -- use undo file
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

opt.swapfile = false -- No swap File
opt.backup = false -- Don't use swap or Backup
opt.writebackup = false -- don't write backup

vim.lsp.log.set_level("OFF") -- DEBUG

opt.spelllang = "en,cjk"
opt.spelloptions:append("noplainbuffer,camel")
opt.spell = false

opt.shell = "/bin/zsh"
opt.termguicolors = true

option.errorbells = false -- Disable error bells
option.showcmd = true -- show's commands in the cmd line

opt.wrap = false
opt.scrolloff = 2 -- minimal screen lines to keep above and below the cursor
opt.sidescroll = 10 -- when nowrap is set and line is longer then window scrolls to the left with using `zl` command

opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block" -- change the shape of the cursor
opt.fillchars = { eob = " " } -- Hide the tilde sign in the blank line

opt.isfname:append("@-@")

option.ruler = true -- Make search act like search in modern browsers

option.synmaxcol = 500 -- Stop syntax highlight on long lines

opt.path:append({ "**" }) -- :find files down into subfolders

-- trick to solve the vim compatible functionality to not let backspace the file
-- content othe then just inserted one
-- opt.backspace = nil

opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true

opt.hidden = true -- Allow to switch buffer without saving

opt.cursorline = false

opt.cmdheight = 1
opt.timeoutlen = 500
opt.number = true
opt.relativenumber = true

option.completeopt = "menu,menuone,noselect" -- completion menu
window_option.signcolumn = "yes" -- column before line numbers
-- Remove artifacts/redraw issue from indent-blankline.nvim
window_option.colorcolumn = "9999"
opt.wildoptions = "pum" -- command line completion menu
opt.wildmode = "longest:full,full" -- completion menu options
opt.pumheight = 16 -- completion menu height

opt.pumblend = 0 -- completion menu blending option
opt.winblend = 0 -- floating windows blending option

local indent = 2
opt.shiftwidth = indent
opt.tabstop = indent
opt.softtabstop = indent
opt.expandtab = false
opt.smartindent = true
opt.autoindent = true
opt.textwidth = 81

opt.shortmess:append("cI") -- turn of completion messages and starting intro screen

-- opt.whichwrap="<>hl"
-- opt.autochdir = true

-- global.nofoldenable = true
-- opt.foldmethod = "marker"
-- opt.foldmarker = "~>,<~"
-- vim.cmd([[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- ]])

-- opt.list = true -- show hidden {space,tab} chars
-- set list chars
local list_chars_symbols = {
	["eol"] = " ",
	["tab"] = "▸ ",
	["trail"] = "·",
	["extends"] = "❯",
	["precedes"] = "❮",
	["conceal"] = "┊",
	["nbsp"] = "␣",
}
for k, v in pairs(list_chars_symbols) do
	opt.listchars:append(k .. ":" .. v)
end

-- Remove default plugins
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
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	global["loaded_" .. plugin] = 1
end

local default_providers = {
	"node",
	"perl",
	"python",
	"python3",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
