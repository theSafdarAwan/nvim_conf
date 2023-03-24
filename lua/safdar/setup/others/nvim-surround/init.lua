local function plugin(install)
	install({
		"kylechui/nvim-surround",
		config = function()
			require("safdar.setup.others.nvim-surround.config").config()
		end,
		event = "BufRead"
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
	})
end

return { install = plugin }
