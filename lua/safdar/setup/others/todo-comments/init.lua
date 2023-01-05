local function plugin(install)
	install({
		"folke/todo-comments.nvim",
		setup = function()
			require("safdar.utils").fused("todocomments")
			local tdc = {
				name = "todo-comments.nvim",
				autocmd = {
					event = "BufEnter",
				},
			}
			require("lazy-loader").load(tdc)
		end,
		config = function()
			require("safdar.setup.others.todo-comments.config").config()
		end,
	})
end

return { install = plugin }
