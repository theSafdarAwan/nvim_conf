local M = {}
local set_map = require("safdar.utils").set_map
function M.maps()
	-- TODO: add some autocmd or mapping so whenever you move between two files then
	-- it should add the previous file to a harpoon nav_file(4) and add the mapping
	-- of <leader>ap.
	-- Harpoon
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
