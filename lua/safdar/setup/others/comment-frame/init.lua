local function plugin(install)
	install({
		opt = true,
		keys = {
			"<leader>cm",
			"<leader>cl",
		},
		"s1n7ax/nvim-comment-frame",
		config = function()
			require("safdar.setup.others.comment-frame.config").config()
		end,
	})
end

return { install = plugin }
