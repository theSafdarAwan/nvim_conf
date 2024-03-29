--[[
	authord: @theSafdarAwan
	date: 02/01/23 - 05:59 AM
	last modifiction date: 04/04/23 - 10:48

	Description:- This is a small script for moving between last two files.

	NOTE> this script is different from the command :buffer # or the Ctrl-^ these don't
	work when we delete a buffer using the vim.api.nvim_buf_delete and i delete buffers
	from telescope buffers which uses this api.
--]]

local api, fn = vim.api, vim.fn
local create_autocmd = api.nvim_create_autocmd

local set_map = require("safdar.utils").set_map

local alternate_buf_list = {}

local function valid_buf()
	if api.nvim_buf_get_option(0, "buflisted") and #vim.bo.buftype < 1 and #fn.expand("%:p") > 1 then
		return true
	end
end
local function get_current_buf()
	local buf = {}
	buf.file_name = fn.expand("%:p")
	buf.cursor_position = api.nvim_win_get_cursor(0)
	buf.buf_nr = api.nvim_get_current_buf()
	return buf
end
create_autocmd({ "BufWinLeave" }, {
	group = api.nvim_create_augroup("alternate file", { clear = true }),
	callback = function()
		if not valid_buf() then
			return
		end
		local current_buf = get_current_buf()
		create_autocmd({ "BufWinEnter" }, {
			once = true,
			callback = function()
				local previous_buf = current_buf
				alternate_buf_list.previous = previous_buf
				if not valid_buf() then
					return
				end
				current_buf = get_current_buf()
				if previous_buf.buf_nr == current_buf.buf_nr then
					return
				else
					alternate_buf_list.current = current_buf
				end
			end,
		})
	end,
})

set_map("n", "gz", function()
	if not alternate_buf_list.previous then
		return
	end

	local previous_buf = alternate_buf_list.previous
	if api.nvim_buf_is_valid(previous_buf.buf_nr) then
		api.nvim_set_current_buf(previous_buf.buf_nr)
	else
		-- create buf and update the buf_nr
		previous_buf.buf_nr = api.nvim_create_buf(true, false)
		api.nvim_set_current_buf(previous_buf.buf_nr)
		vim.cmd("edit " .. previous_buf.file_name)
		api.nvim_win_set_cursor(0, previous_buf.cursor_position)
	end
end)
