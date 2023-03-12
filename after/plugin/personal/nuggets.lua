----------------------------------------------------------------------
--        A script that goes to the position where you were         --
--                after yanking using a text object                 --
----------------------------------------------------------------------
local api = vim.api
local fn = vim.fn
local map_opts = { noremap = true, silent = true }
local function yank_callback(callback)
	local cursor_position = api.nvim_win_get_cursor(0)
	vim.keymap.set("n", "y", "y", map_opts)
	local chars = ""
	while true do
		local c = fn.getchar()
		if type(c) ~= "number" or c < 65 or c > 127 then
			return
		end
		chars = chars .. fn.nr2char(c)
		if #chars == 2 then
			break
		end
		if #chars == 1 and c ~= 97 or c ~= 105 then
			break
		end
	end
	api.nvim_feedkeys("y" .. chars, "n", false)
	vim.keymap.set("n", "y", function()
		callback(callback)
	end)
	vim.defer_fn(function()
		api.nvim_win_set_cursor(0, cursor_position)
	end, 0)
end

vim.keymap.set("n", "y", function()
	yank_callback(yank_callback)
end, map_opts)
