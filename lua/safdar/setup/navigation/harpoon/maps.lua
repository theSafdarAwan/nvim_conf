local M = {}
local utils = require("safdar.utils")
local a = vim.api
local fn = vim.fn
local set_map = utils.set_map
local set_buf_map = utils.set_buf_map
local enabled_float_term = true

a.nvim_create_user_command("ToggleHarpoonFloatTerm", function()
	if enabled_float_term then
		enabled_float_term = false
	else
		enabled_float_term = true
	end
end, {})

local create_popup = function()
	if not enabled_float_term then
		return
	end

	local width = 80
	local height = 33
	local row = 3
	local col = 9

	local buf = 0
	vim.api.nvim_open_win(buf, true, {
		col = col,
		row = row,
		width = width,
		border = "single",
		height = height,
		relative = "editor",
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "terminal",
		group = vim.api.nvim_create_augroup("harpoon float terminal", { clear = true }),
		command = [[ lua
				   vim.opt_local.signcolumn = 'no'
		]],
	})

	a.nvim_feedkeys("i", "n", false)
end

function M.maps()
	set_map("n", "<leader>aa", ":lua require('harpoon.mark').add_file()<CR>")
	set_map("n", "<leader>ah", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aH", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aj", ":lua require('harpoon.ui').nav_file(1)<cr>")
	set_map("n", "<leader>ak", ":lua require('harpoon.ui').nav_file(2)<cr>")
	set_map("n", "<leader>al", ":lua require('harpoon.ui').nav_file(3)<cr>")

	-- Terminal's
	set_map("n", "<leader>tj", function()
		create_popup()
		require("harpoon.term").gotoTerminal(1)
	end)
	set_map("n", "<leader>tk", function()
		create_popup()
		require("harpoon.term").gotoTerminal(2)
	end)
	set_map("n", "<leader>tl", function()
		create_popup()
		require("harpoon.term").gotoTerminal(3)
	end)

	--[[ -- tmux Terminals
	set_map("n", "<leader>tj", ":lua require('harpoon.tmux').gotoTerminal(1)<cr>")
	set_map("n", "<leader>tk", ":lua require('harpoon.tmux').gotoTerminal(2)<cr>")
	set_map("n", "<leader>tl", ":lua require('harpoon.tmux').gotoTerminal(3)<cr>") ]]
end

M.c_lang = function()
	set_buf_map(0, "n", "<leader>ts", ":lua require('harpoon.term').sendCommand(1, './compile')<CR>")
	-- set_buf_map(0, "n", "<leader>ts", ":lua require('harpoon.tmux').sendCommand(1, './compile')<CR>", opts)
end

M.common_lisp = function()
	local map_opts = utils.map_options
	set_map("n", "<leader>ts", function()
		local file_name = fn.expand("%:tr")
		if string.find(file_name, ".lisp", 1, true) then
			require("harpoon.term").sendCommand(1, "clisp " .. file_name)
		end
	end, map_opts:new():silent():noremap():buffer(0))
end

M.keys = {
	"<leader>aa",
	"<leader>aj",
	"<leader>ak",
	"<leader>al",
	"<leader>aH",
	"<leader>ah",
	"<leader>af",
	"<leader>tj",
	"<leader>tk",
	"<leader>tl",
}
return M
