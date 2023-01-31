local files_info = {}

local api = vim.api

api.nvim_create_autocmd("BufLeave", {
	group = api.nvim_create_augroup("file toggler", { clear = true }),
	callback = function()
		-- check if the buffer has a name or is created
		local buf_name = api.nvim_buf_get_name(0)
		if #buf_name < 1 then
			return
		end

		local is_hidden = api.nvim_buf_get_option(0, "bufhidden")
		if #is_hidden > 1 then
			return
		end

		-- need to make sure that the first and the second files are not the same
		if #files_info > 1 and files_info[1].file_name == files_info[2].file_name then
			return
		end

		if #files_info > 1 then
			files_info[2] = files_info[1]
		end

		files_info[1] = {}
		files_info[1].file_name = buf_name
		files_info[1].cursor = api.nvim_win_get_cursor(0)
	end,
})

vim.keymap.set("n", "<leader>ll", function()
	vim.cmd("edit " .. files_info[1].file_name)
	vim.schedule_wrap(function()
		api.nvim_win_set_cursor(0, files_info[1].cursor)
	end)
end)
