local vim = vim

vim.cmd([[
let g:user_emmet_mode='i'    "only enable normal mode functions.
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:user_emmet_leader_key='<C-e>'
]])
