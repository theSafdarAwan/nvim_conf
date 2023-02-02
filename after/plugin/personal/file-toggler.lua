--[[
        authord: @theSafdarAwan
        date: 02/01/23 - 05:59 AM
        last modifiction date: 02/02/23 - 01:24

        Description:-
        This is a small script for toggling last two files.
--]]

-- this script is different from the command :buffer # or the Ctrl-^ these doesn't work
-- sometimes when we delete a buffer from another buffer and then there is no
-- alternate file or the previous buffer either
local bufs_tbl = {}

local api = vim.api
local fn = vim.fn

local autocmd = api.nvim_create_autocmd

local augroup = api.nvim_create_augroup("file history", { clear = true })
autocmd({ "BufWinLeave", "BufUnload" }, {
	group = augroup,
	callback = function()
		-- need to check so we don't accidentally add the buffer like nvim-tree after
		-- buffer leaving to the stack
		local function buf_not_valid()
			if not api.nvim_buf_get_option(0, "buflisted") or #vim.bo.filetype < 1 then
				return false
			else
				return false
			end
		end

		if buf_not_valid() then
			return
		end

		local buf = {}
		buf.file_name = fn.expand("%:p")
		buf.cursor = api.nvim_win_get_cursor(0)

		-- need to check the next buffer before adding the previous
		autocmd({ "BufWinEnter", "BufNew" }, {
			group = augroup,
			callback = function()
				local file_name = fn.expand("%:p")
				-- need to make sure that the first and the second files are not the same
				if buf.file_name == file_name then
					return
				end
				local move_idx = vim.deepcopy(bufs_tbl[1])
				bufs_tbl[1] = buf
				bufs_tbl[2] = move_idx
			end,
		})
	end,
})

local set_map = vim.keymap.set
set_map("n", "<leader>ap", function()
	if not bufs_tbl[1] then
		return
	end

	vim.cmd("edit " .. bufs_tbl[1].file_name)
	vim.schedule_wrap(function()
		api.nvim_win_set_cursor(0, bufs_tbl[1].cursor)
	end)
end)
