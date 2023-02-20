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

--[[
        authord: @theSafdarAwan
        date: 02/01/23 - 05:59 AM
        last modifiction date: 02/02/23 - 09:37

        Description:-
        This is a small script for moving between last two files.

        NOTE: this script is different from the command :buffer # or the Ctrl-^ these don't
		work when we delete a buffer using the vim.api.nvim_buf_delete and i delete buffers
		from telescope buffers which uses this api.
--]]

local autocmd = api.nvim_create_autocmd

-- TODO: create a database dir that keeps track of the current directory and
-- the alternate_bufs so that we can move even after exiting the neovim
local alternate_bufs = {}

local augroup = api.nvim_create_augroup("alternate file movment", { clear = true })
autocmd({ "BufWinLeave" }, {
	group = augroup,
	callback = function()
		-- need to check so we don't accidentally add the buffer like nvim-tree
		-- or buffer with empty file_name string
		if not api.nvim_buf_get_option(0, "buflisted") or #vim.bo.buftype > 1 or #fn.expand("%:p") < 1 then
			return
		end

		local current_buf = {}
		current_buf.file_name = fn.expand("%:p")
		current_buf.cursor_position = api.nvim_win_get_cursor(0)
		current_buf.buf_number = fn.bufnr()

		-- need to check the next buffer before adding the previous
		autocmd({ "BufWinEnter" }, {
			group = augroup,
			callback = function()
				local previous_buf = current_buf
				-- need to make sure that the first and the second files are not the same
				if previous_buf.file_name == fn.expand("%:p") then
					return
				end
				-- moving the current buf to the last index
				alternate_bufs[2], alternate_bufs[1] = alternate_bufs[1], previous_buf
			end,
		})
	end,
})

set_map("n", "<C-z>", function()
	if not alternate_bufs[1] then
		return
	end

	local previous_buf = alternate_bufs[1]
	if api.nvim_buf_is_valid(previous_buf.buf_number) then
		api.nvim_set_current_buf(previous_buf.buf_number)
	else
		previous_buf.buf_number = api.nvim_create_buf(true, false)
		api.nvim_set_current_buf(previous_buf.buf_number)
		vim.cmd("edit " .. previous_buf.file_name)
		api.nvim_win_set_cursor(0, previous_buf.cursor_position)
	end
end)
