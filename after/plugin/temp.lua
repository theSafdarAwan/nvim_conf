--:h lua 642
-- TODO: work with notify
-- local plugin = "My Awesome Plugin"
--
-- vim.notify("This is an error message.\nSomething went wrong!", "error", {
-- 	title = plugin,
-- 	on_open = function()
-- 		vim.notify("Attempting recovery.", vim.log.levels.WARN, {
-- 			title = plugin,
-- 		})
-- 		local timer = vim.loop.new_timer()
-- 		timer:start(2000, 0, function()
-- 			vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
-- 				title = plugin,
-- 				timeout = 3000,
-- 				on_close = function()
-- 					vim.notify("Problem solved", nil, { title = plugin })
-- 					vim.notify("Error code 0x0395AF", 1, { title = plugin })
-- 				end,
-- 			})
-- 		end)
-- 	end,
-- })
--
-- local async = require("plenary.async")
-- local notify = require("notify").async
--
-- async.run(function()
--   notify("Let's wait for this to close").events.close()
--   notify("It closed!")
-- end)

-- Trying to understand the User autocmd's
local aug = vim.api.nvim_create_augroup("clear the This_is_user_autocmd", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
	group = aug,
	-- pattern = "This_is_user_autocmd",
	callback = function()
		-- print("this is right")
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = vim.api.nvim_create_augroup("you are right", { clear = true }),
	pattern = "clear the This_is_user_autocmd",
	callback = function()
		vim.cmd("do This_is_user_autocmd")
	end,
})
