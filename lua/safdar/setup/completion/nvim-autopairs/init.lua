local function plugin(install)
	install({
		"windwp/nvim-autopairs",
		config = function()
			require("safdar.setup.completion.nvim-autopairs.config").config()
		end,
		event = { "InsertEnter" },
	})
end

return { install = plugin }
