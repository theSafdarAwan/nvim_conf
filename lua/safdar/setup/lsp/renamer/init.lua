local function plugin(install)
	install({
		"filipdutescu/renamer.nvim",
		branch = "master",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("safdar.utils").fused("renamer.nvim")
			require("safdar.setup.lsp.renamer.config").config()
		end,
		keys = { "yr" },
	})
end

return { install = plugin }
