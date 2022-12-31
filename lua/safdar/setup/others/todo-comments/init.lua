local function plugin(install)
	install({
		"folke/todo-comments.nvim",
		event = "BufWinEnter",
		setup = function ()
			require("safdar.utils").fused("todocomments")
		end,
		config = function()
			require("safdar.setup.others.todo-comments.config").config()
		end,
	})
end

return { install = plugin }
