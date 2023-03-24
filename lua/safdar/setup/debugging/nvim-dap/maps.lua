local M = {}

local utils = require("safdar.utils")
local set_map = utils.set_map
local opts = { noremap = true, silent = true }

M.dap_ui_maps = function()
	set_map("n", "_u", "<cmd>lua require('dapui').open()<CR>", opts)
	set_map("n", "_t", "<cmd>lua require('dapui').toggle()<CR>", opts)
	set_map("n", "_c", "<cmd>lua require('dapui').close()<CR>", opts)
	set_map("n", "_e", "<cmd>lua require('dapui').eval()<CR>", opts)
end

M.dap_ui_mappings = {
	-- Use a table to apply multiple mappings
	expand = { "<CR>", "<2-LeftMouse>" },
	open = "o",
	remove = "d",
	edit = "e",
	repl = "r",
	toggle = "t",
}

M.dap_maps = function()
	set_map("n", "_s", "<cmd>lua require'dap'.continue()<CR>", opts)
	set_map("n", "_b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
	set_map("n", "_B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
	set_map("n", "_o", "<cmd>lua require'dap'.step_over()<CR>", opts)
	set_map("n", "_i", "<cmd>lua require'dap'.step_into()<CR>", opts)
	set_map("n", "_O", "<cmd>lua require'dap'.repl.open()<CR>", opts)

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
end

return M
