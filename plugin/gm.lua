--[[
		authord: @theSafdarAwan
		last modifiction date: 04/04/23 - 10:48
		Description:- Script that doesn't leve the position when yanking
--]]
local set_map = require("safdar.utils").set_map

local api = vim.api
local fn = vim.fn

-- replace the default nvim map gm for rather the half of the screen to half of
-- the current line text
set_map({ "n", "v" }, "gm", function()
	local current_line = #api.nvim_get_current_line()
	local middle = math.floor(current_line / 2)
	local cursor_position = fn.getpos(".")[3]

	if cursor_position == middle then
		return
	end

	local key
	local move
	if cursor_position > middle then
		key = "h"
		move = cursor_position - middle
	elseif cursor_position < middle then
		key = "l"
		move = middle - cursor_position
	end

	if not move then
		return
	end

	fn.feedkeys(move)
	api.nvim_feedkeys(key, "m", true)
end)
