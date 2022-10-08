local vim = vim
local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- enable mouse
-- opt.mouse = "a"
-- disable mouse
opt.mouse = ""

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

-- folding
opt.foldmethod="marker"
opt.foldmarker="-->,<--"
-- vim.cmd([[
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- ]])

-- finding files - search down into subfolders
opt.path:append({ "**" })

-- Hide the tilde singn in the blank line
opt.fillchars = { eob = " " }

opt.undofile = true
opt.updatetime = 500
opt.undodir = os.getenv("HOME") .. "/.nvim_undodir/"

-- no swap file i use undofile
opt.swapfile = false

-- trick to solve the vim compatible functionality to not let backspace the file content othe then just inserted one
-- opt.backspace = nil

opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true

opt.cursorline = true

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
opt.softtabstop = 4
opt.smartindent = true
opt.expandtab = true

-- opt.shortmess:append("c")
-- opt.isfname:append("@-@")

-- opt.whichwrap="<>hl"
-- opt.autochdir = true
opt.cursorline = true

-- sets the column on the left side (or before) of the line numbers
vim.wo.signcolumn = "yes"

vim.cmd([[
" Highlight The yanked text
augroup highlight_yank
autocmd!
autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
]])

-- Help Helper Function
vim.cmd([[
function! HelpHelper()
    setlocal relativenumber
    setlocal number
    " :h conceal|conceal
    setlocal conceallevel=0
    hi link HelpBar Normal
    hi link HelpStar Normal
endfunction
]])

-- set spell for the gitcommit message's and other filetypes
vim.cmd([[
autocmd FileType gitcommit setlocal spell
autocmd FileType NeogitCommitMessage setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell
autocmd FileType help call HelpHelper()
]])

vim.cmd([[
" File extension specific tabbing
" autocmd Filetype css setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Open a file from its last left off position
" au BufReadPost * if expand('%:p') !~# 'm/.git/' && line("'"") > 1 && line("'"") <= line("$") | exe "normal! g'"" | endif 
]])
vim.cmd([[
" Don't show the line numbers in terminal mode
autocmd TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
]])

-- Damian Conway
vim.cmd([[
    " this will use the Color defined in you theme for the ColorColumn
    autocmd BufEnter * call matchadd('ColorColumn', '\%80v') 
]])

-- Colorizer plugin attach autocmd's
vim.cmd([[
autocmd BufEnter * ColorizerAttachToBuffer
autocmd InsertLeave * ColorizerAttachToBuffer
autocmd CursorMoved * ColorizerAttachToBuffer
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
