local function plugin(install)
	install({
		"folke/todo-comments.nvim",
		setup = function()
			require("safdar.utils").fused("todo-comments.nvim")
			local tdc = {
				name = "todo-comments.nvim",
				autocmd = {
					event = "BufEnter",
				},
				on_load = {
					config = function()
						require("safdar.setup.others.todo-comments.config").config()
					end,
				},
			}
			require("lazy-loader").load(tdc)
		end,
	})
end

return { install = plugin }
