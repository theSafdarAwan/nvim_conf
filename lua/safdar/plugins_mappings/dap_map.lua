local utils = require("safdar.core.utils")
local map = utils.map
local opts = { noremap = true, silent = true }

map("n", "[ds", "<cmd>lua require'dap'.continue()<CR>", opts)
map("n", "[db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
map(
    "n",
    "[dB",
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    opts
)
map("n", "[do", "<cmd>lua require'dap'.step_over()<CR>", opts)
map("n", "[di", "<cmd>lua require'dap'.step_into()<CR>", opts)
map("n", "[dO", "<cmd>lua require'dap'.repl.open()<CR>", opts)

-- TODO: read the documentation and add the mappings

--[[
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
]]
