local M = {}
local utils = require("safdar.utils")
local api = vim.api
local fn = vim.fn
local set_map = utils.set_map
local set_buf_map = utils.set_buf_map
local enabled_float_term = true

api.nvim_create_user_command("ToggleHarpoonFloatTerm", function()
	if enabled_float_term then
		enabled_float_term = false
	else
		enabled_float_term = true
	end
end, {})

--- close poup window if it has `_is_popup` variable
local function close_poup()
	if pcall(api.nvim_win_get_var, 0, "_is_popup") then
		api.nvim_win_close(0, true)
	end
end

local group = api.nvim_create_augroup("harpoon float terminal", { clear = true })
-- set no signcolumn for terminal file types
api.nvim_create_autocmd("FileType", {
	pattern = "terminal",
	group = group,
	command = "lua vim.opt_local.signcolumn = 'no'",
})
-- close poup window before leaving to another window
api.nvim_create_autocmd("WinLeave", {
	group = group,
	callback = function()
		close_poup()
	end,
})

local create_popup = function()
	if not enabled_float_term then
		return
	end

	close_poup()

	local ui = vim.api.nvim_list_uis()[1]

	local width = 80
	local height = 33

	local buf = 0
	local win = api.nvim_open_win(buf, true, {
		col = (ui.width - width) / 2,
		row = (ui.height - height) / 2,
		width = width,
		border = "single",
		height = height,
		relative = "editor",
	})
	api.nvim_win_set_var(win, "_is_popup", true)
	-- start insert mode after creating popup window
	api.nvim_feedkeys("i", "n", false)
end

function M.maps()
	set_map("n", "<leader>aa", function()
		require("harpoon.mark").add_file()
	end)
	set_map("n", "<leader>ah", function()
		require("harpoon.ui").toggle_quick_menu()
	end)
	set_map("n", "<leader>aH", function()
		require("harpoon.cmd-ui").toggle_quick_menu()
	end)

	---@diagnostic disable-next-line: lowercase-global
	function nav_file(file_nr)
		close_poup()
		require("harpoon.ui").nav_file(file_nr)
	end

	set_map("n", "<leader>aj", ":lua nav_file(1)<CR>")
	set_map("n", "<leader>ak", ":lua nav_file(2)<CR>")
	set_map("n", "<leader>al", ":lua nav_file(3)<CR>")

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
