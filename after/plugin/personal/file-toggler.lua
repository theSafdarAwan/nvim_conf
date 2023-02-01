--[[
        authord: @theSafdarAwan
        date: 02/01/23 - 05:59 AM
        last modifiction date: 02/01/23 - 06:00

        Description:-
        This is a small script for toggling last two files.
--]]

local files_info = {}

local api = vim.api
local fn = vim.fn

api.nvim_create_autocmd({ "BufWinLeave", "BufLeave", "BufDelete", "BufUnload" }, {
	group = api.nvim_create_augroup("file toggler BufLeave", { clear = true }),
	callback = function()
		-- need to check so we don't accidentally add the buffer like nvim-tree after
		-- buffer leaving to the stack
		if not api.nvim_buf_get_option(0, "buflisted") or #vim.bo.filetype < 1 then
			return
		end

		local buf_name = fn.expand("%:p")
		local buffer = {}
		buffer.file_name = buf_name
		buffer.buf_nr = fn.bufnr()
		buffer.cursor = api.nvim_win_get_cursor(0)

		-- need to check the next buffer before moving the previous one
		api.nvim_create_autocmd({ "BufWinEnter", "BufNew", "BufRead", "BufAdd", "BufEnter" }, {
			group = api.nvim_create_augroup("file toggler BufWinEnter", { clear = true }),
			callback = function()
				-- need t o
				if not api.nvim_buf_get_option(0, "buflisted") or #vim.bo.filetype < 1 then
					return
				end

				-- need to make sure that the first and the second files are not the same
				if buffer.file_name == fn.expand("%:p") then
					return
				end

				files_info[2] = files_info[1]
				files_info[1] = buffer
			end,
		})
	end,
})

vim.keymap.set("n", "<leader><leader>", function()
	if not files_info[1] then
		return
	end

	vim.cmd("edit " .. files_info[1].file_name)
	vim.schedule_wrap(function()
		api.nvim_win_set_cursor(0, files_info[1].cursor)
	end)
end)
