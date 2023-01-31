local M = {}
local utils = require("safdar.utils")
local set_map = utils.set_map
local set_buf_map = utils.set_buf_map
function M.maps()
	set_map("n", "<leader>aa", ":lua require('harpoon.mark').add_file()<CR>")
	set_map("n", "<leader>ah", ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aH", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
	set_map("n", "<leader>aj", ":lua require('harpoon.ui').nav_file(1)<cr>")
	set_map("n", "<leader>ak", ":lua require('harpoon.ui').nav_file(2)<cr>")
	set_map("n", "<leader>al", ":lua require('harpoon.ui').nav_file(3)<cr>")

	-- local api = vim.api
	-- local last_buf_name = nil
	-- local deletion_buf = nil
	-- local excluded = {
	-- 	ft = { "TelescopePrompt", "harpoon" },
	-- 	buf = { "prompt" },
	-- }
	-- TODO: 
	-- 1) rather then adding and deleting like this create a database on
	-- bufwinenter through which you can toggle between last two files
	-- 2) Or just leave the harpoon and create a little script that allows you to
	-- navigate you through the last two files by getting the exact positions of
	-- of the cursor and the file name before so that i can get back to the exact
	-- same position
	-- 3) consult with the harpoon devs that would they except a feature that
	-- would allow user to navigate between last two files and implement it
	-- inside the harpoon

	-- api.nvim_create_autocmd("BufLeave", {
	-- 	group = api.nvim_create_augroup("add harpoon current file", { clear = true }),
	-- 	callback = function()
	-- 		-- check for the excluded file type
	-- 		for _, ft in ipairs(excluded.ft) do
	-- 			if vim.bo.filetype == ft then
	-- 				return
	-- 			end
	-- 		end
	--
	-- 		-- check for the excluded buf type
	-- 		for _, buftype in ipairs(excluded.buf) do
	-- 			if vim.bo.buftype == buftype then
	-- 				return
	-- 			end
	-- 		end
	--
	-- 		-- check if the buffer has a name or is created
	-- 		local buf_name = api.nvim_buf_get_name(0)
	-- 		if last_buf_name and #last_buf_name < 1 then
	-- 			return
	-- 		end
	--
	-- 		if last_buf_name then
	-- 			require("harpoon.mark").rm_file(deletion_buf)
	-- 		end
	--
	-- 		if last_buf_name then
	-- 			local marks = require("harpoon").get_mark_config()
	-- 			deletion_buf = marks[#marks]
	-- 		end
	--
	-- 		require("harpoon.mark").add_file(last_buf_name)
	-- 		last_buf_name = buf_name
	-- 	end,
	-- })
	-- set_map("n", "<leader>ll", function()
	-- 	if last_buf_name then
	-- 		require("harpoon.ui").nav_file(last_buf_name)
	-- 	end
	-- end)

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

M.keys = {
	{ "n", "<leader>ll" },
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
