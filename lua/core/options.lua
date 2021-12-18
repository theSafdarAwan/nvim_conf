local vim = vim
local opt = vim.opt
local g = vim.g
g.mapleader = " "
vim.cmd[[
    colorscheme dracula-sid
]]
-- FIX:
-- g.colors_name = "dracula-sid"
-- g.ayucolor = "light"
-- g.ayucolor = "mirage"
-- g.ayucolor = "dark"

-- g.colors_name = "gruvbox"
-- vim.cmd[[
-- autocmd VimEnter * so ~/.config/nvim/colors/bg_transparent.vim
-- ]]

opt.mouse = "a"

-- Spell Checking lang
opt.spelllang = "en,cjk"

-- set the terminal
opt.shell = "/bin/zsh"
opt.termguicolors = true

opt.wrap = false
opt.scrolloff = 2
opt.showmode = false
opt.wrap = false
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- Hide the tilde singn in the blank line
opt.fillchars = { eob = " " }

-- check the :h undofile option its descreption is very long
opt.undofile = true

-- no swap file
opt.swapfile = false

-- trick to solve the vim compatible functionality
-- opt.backspace=

opt.ignorecase = true
opt.splitright = true
opt.splitbelow = true

opt.cursorline = true

opt.cmdheight = 1
-- opt.timeoutlen = 800
-- line numbers
opt.number = true
opt.relativenumber = true

opt.pumheight = 26

-- Indenline
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.expandtab = true

-- opt.shortmess = "I"

-- opt.whichwrap="<>hl"
-- opt.autochdir = true
opt.cursorline = true

-- sets the column on the left side (or before) of the line numbers
vim.wo.signcolumn = 'yes'

-- Netrw Settings
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_localrmdir = "rm -r"

vim.cmd[[
autocmd BufEnter *.norg set spell shiftwidth=2 tabstop=2 softtabstop=2
]]

vim.cmd([[
"=====================================================
"                  custom manipluations
"=====================================================
" " cursor settings
" highlight Cursor guifg=white guibg=yellow
" highlight iCursor guifg=white guibg=#b8bb26
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
" set guicursor+=n-v-c:blinkon0
" set guicursor+=i:blinkwait10
]])

vim.cmd([[
" Highlight The yanked text
augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
]])

vim.cmd([[
"=====================================================
"                  autocmd
"=====================================================

" Don't show the line numbers in terminal mode
autocmd TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" File extension specific tabbing
" autocmd Filetype css setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Open a file from its last left off position
" au BufReadPost * if expand('%:p') !~# 'm/.git/' && line("'"") > 1 && line("'"") <= line("$") | exe "normal! g'"" | endif 
]])

-- Damian Conway
vim.cmd([[
" call matchadd('ColorColumn', '\%81v', 100) " for a moment be quite because now i am using linters
]])

-- Colorizer plugin attach
vim.cmd([[
autocmd VimEnter * ColorizerAttachToBuffer
autocmd InsertLeave * ColorizerAttachToBuffer
]])

-- =====================================================
--                   Remove Built Plugins
-- =====================================================
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	-- "netrw",
	-- "netrwPlugin",
	-- "netrwSettings",
	-- "netrwFileHandlers",
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
