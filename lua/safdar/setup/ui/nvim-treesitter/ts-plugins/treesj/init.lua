local function plugin(install)
	install({
		"Wansmer/treesj",
		keys = { "gts", "gtj", "gtt" },
		config = function()
			require("treesj").setup({ -- Use default keymaps
				use_default_keymaps = false,
				-- langs = langs,
			})
			local set_map = require("safdar.utils").set_map
			set_map("n", "gts", ":TSJSplit<CR>")
			set_map("n", "gtj", ":TSJJoin<CR>")
			set_map("n", "gtt", ":TSJToggle<CR>")
		end,
	})
end

return { install = plugin }
