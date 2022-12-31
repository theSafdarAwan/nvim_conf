local function plugin(install)
	install({
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		setup = function ()
			require("safdar.utils").fused("renamer")
		end,
		config = function()
			require("safdar.setup.lsp.renamer.config").config()
		end,
		keys = {
			{ "n", "yr" },
		},
	})
end

return { install = plugin }
