local set_map = require("safdar.utils").set_map

local api = vim.api
local fn = vim.fn

-- replace the default nvim map gm for rather the half of the screen to half of
-- the current line text
set_map({ "n", "v" }, "gm", function()
	local current_line = #api.nvim_get_current_line()
	local middle = math.floor(current_line / 2)
	local position = api.nvim_win_get_cursor(0)[2]

	if position == middle then
		return
	end

	local key
	local move
	if position > middle then
		key = "h"
		move = position - middle
	elseif position < middle then
		key = "l"
		move = middle - position
	end

	if not move then
		return
	end

	fn.feedkeys(move)
	api.nvim_feedkeys(key, "m", true)
end)
