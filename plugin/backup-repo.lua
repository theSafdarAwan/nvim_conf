local api, fn = vim.api, vim.fn
local bufnr = vim.fn.bufnr()
-- TODO: write this script
local function start_backup()
	local dir_name = fn.expand("%")
	fn.jobstart({ "mv ~/" }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
		end,
		on_stderr = function(_, data)
		end,
	})
end

vim.keymap.set("n", "gB", function()
	-- start_backup()
end, { noremap = true, silent = true })
