local function plugin(install)
	install({
		"filipdutescu/renamer.nvim",
		branch = "master",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("fused").load_plugin("renamer.nvim")
			require("safdar.setup.lsp.renamer-nvim.config").config()
		end,
		keys = { "yr" },
	})
end

return { install = plugin }