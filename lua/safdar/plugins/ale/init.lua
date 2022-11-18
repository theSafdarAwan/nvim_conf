local utils = require("safdar.core.utils")
local cmd = utils.cmd

cmd([[
let b:ale_linters = ['htmlhint']
]])

cmd([[
let g:ale_sign_error = ''
let g:ale_sign_warning = ' '
]])

-- Trick
cmd([[
autocmd BufEnter * ALEDisable
autocmd BufEnter *.html ALEEnable
]])

require("safdar.plugins.ale.maps")
