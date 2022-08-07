local vim = vim

vim.cmd([[
let b:ale_linters = ['htmlhint']
]])

vim.cmd([[
let g:ale_sign_error = ' ●'
let g:ale_sign_warning = ' '
]])

-- Trick
vim.cmd[[
autocmd BufEnter * ALEDisable
autocmd BufEnter *.html ALEEnable
]]
