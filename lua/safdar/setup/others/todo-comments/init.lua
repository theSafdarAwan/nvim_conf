local function plugin(install)
	install({
		"folke/todo-comments.nvim",
		event = "BufEnter",
		config = function()
			require("safdar.utils").fused("todo-comments.nvim")
			require("safdar.setup.others.todo-comments.config").config()
		end,
	})
end

return { install = plugin }
