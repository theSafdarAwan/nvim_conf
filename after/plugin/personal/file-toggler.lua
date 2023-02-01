--[[
        authord: @theSafdarAwan
        date: 02/01/23 - 05:59 AM
        last modifiction date: 02/02/23 - 01:24

        Description:-
        This is a small script for toggling last two files.
--]]

local bufs_info = {}

local api = vim.api
local fn = vim.fn

local augroup = api.nvim_create_augroup("file toggler", { clear = true })
api.nvim_create_autocmd({ "BufWinLeave", "BufUnload" }, {
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

		buf.buf_nr = fn.bufnr()
		buf.cursor = api.nvim_win_get_cursor(0)

		-- need to check the next buffer before moving the previous one
		api.nvim_create_autocmd({ "BufWinEnter", "BufNew" }, {
			group = augroup,
			callback = function()
				local file_name = fn.expand("%:p")
				-- need to make sure that the first and the second files are not the same
				if buf.file_name == file_name then
					return
				end
				local move_idx = vim.deepcopy(bufs_info[1])
				bufs_info[1] = buf
				bufs_info[2] = move_idx
			end,
		})
	end,
})

vim.keymap.set("n", "<leader>ap", function()
	if not bufs_info[1] then
		return
	end

	vim.cmd("edit " .. bufs_info[1].file_name)
	vim.schedule_wrap(function()
		api.nvim_win_set_cursor(0, bufs_info[1].cursor)
	end)
end)
