local set_map = require("safdar.utils").set_map

-- replace the default nvim map gm for rather the half of the screen to half of
-- the current line text
set_map({ "n", "v" }, "gm", function()
	local api = vim.api
	local fn = vim.fn

	local cur_line = #api.nvim_get_current_line()
	local middle = math.floor(cur_line / 2)
	local pos = api.nvim_win_get_cursor(0)[2]

	if pos == middle then
		return
	end

	local key = "l"
	local move
	if pos > middle then
		key = "h"
		move = pos - middle
	elseif pos < middle then
		move = middle - pos
	end

	if not move then
		return
	end

	fn.feedkeys(move)
	api.nvim_feedkeys(key, "m", true)
end)
