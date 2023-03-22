local function plugin(install)
	install({
		"windwp/nvim-autopairs",
		config = function()
			require("safdar.setup.completion.autopairs.config").config()
		end,
		event = { "InsertEnter" },
	})
end

return { install = plugin }
