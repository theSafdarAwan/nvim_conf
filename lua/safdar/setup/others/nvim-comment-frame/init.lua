local function plugin(install)
	install({
		keys = {
			"<leader>cm",
			"<leader>cl",
		},
		"s1n7ax/nvim-comment-frame",
		config = function()
			require("safdar.setup.others.nvim-comment-frame.config").config()
		end,
	})
end

return { install = plugin }
