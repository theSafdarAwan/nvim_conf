local files_info = {}

local api = vim.api

api.nvim_create_autocmd("BufWinLeave", {
	group = api.nvim_create_augroup("file toggler BufLeave", { clear = true }),
	callback = function()
		local buf_name = api.nvim_buf_get_name(0)
		local file = {}
		file.file_name = buf_name
		file.buf_nr = vim.fn.bufnr()
		file.cursor = api.nvim_win_get_cursor(0)

		-- need to check the next buffer before adding the previous one
		api.nvim_create_autocmd("BufWinEnter", {
			group = api.nvim_create_augroup("file toggler BufWinEnter", { clear = true }),
			callback = function()
				-- returns if the hidden string is not empty and the filetype isn't an
				-- empty string
				local buf_is_listed = api.nvim_buf_get_option(0, "buflisted")
				if not buf_is_listed or #vim.bo.filetype < 1 then
					return
				end

				-- need to make sure that the first and the second files are not the same
				if file.file_name == api.nvim_buf_get_name(0) then
					return
				end

				-- check if the first key is present in the files_info table then move it
				-- to the second
				if files_info[1] then
					files_info[2] = file
				end

				files_info[1] = file
			end,
		})
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	if #files_info < 1 then
		return
	end

	vim.cmd("edit " .. files_info[1].file_name)
	vim.schedule_wrap(function()
		api.nvim_win_set_cursor(0, files_info[1].cursor)
	end)
end)
