local M = {}
local utils = require("safdar.utils")
local fn = vim.fn
local set_map = utils.set_map
local set_buf_map = utils.set_buf_map
function M.maps()
	set_map("n", "<leader>aa", ":lua require('harpoon.mark').add_file()<CR>")
	set_map("n", "<leader>ah", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aH", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aj", ":lua require('harpoon.ui').nav_file(1)<cr>")
	set_map("n", "<leader>ak", ":lua require('harpoon.ui').nav_file(2)<cr>")
	set_map("n", "<leader>al", ":lua require('harpoon.ui').nav_file(3)<cr>")

	-- Terminal's
	set_map("n", "<leader>tj", ":lua require('harpoon.term').gotoTerminal(1)<cr>")
	set_map("n", "<leader>tk", ":lua require('harpoon.term').gotoTerminal(2)<cr>")
	set_map("n", "<leader>tl", ":lua require('harpoon.term').gotoTerminal(3)<cr>")

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
	{ "n", "<leader>aa" },
	{ "n", "<leader>aj" },
	{ "n", "<leader>ak" },
	{ "n", "<leader>al" },
	{ "n", "<leader>aH" },
	{ "n", "<leader>ah" },
	{ "n", "<leader>af" },
	{ "n", "<leader>tj" },
	{ "n", "<leader>tk" },
	{ "n", "<leader>tl" },
}
return M
