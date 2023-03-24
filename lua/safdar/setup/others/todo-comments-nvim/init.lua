local function plugin(install)
	install({
		"folke/todo-comments.nvim",
		event = "BufEnter",
		config = function()
			require("fused").load_plugin("todo-comments.nvim")
			require("safdar.setup.others.todo-comments-nvim.config").config()
		end,
	})
end

return { install = plugin }
