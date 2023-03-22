local function plugin(install)
	install({
		"kylechui/nvim-surround",
		config = function()
			require("safdar.setup.others.surround.config").config()
		end,
		keys = {
			{ mode = "v", "S" },
			"d",
			"y",
			"c",
		},
		-- tag = "main", -- Use for stability; omit to use `main` branch for the latest features
	})
end

return { install = plugin }
