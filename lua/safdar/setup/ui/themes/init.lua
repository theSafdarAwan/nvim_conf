local function themes(install)
	install({
		"ellisonleao/gruvbox.nvim",
	})
	install({
		"catppuccin/nvim",
	})
	install({
		"LunarVim/Colorschemes",
	})
	install({
		"nvchad/base46",
		config = function()
			-- local base46 = require("base46")
			-- base46.load_theme()
			-- base46.load_highlight("treesitter")
		end,
	})
	install({
		"folke/tokyonight.nvim",
		config = function()
			-- require("safdar.setup.ui.themes.config").tokyonight()
		end,
	})
	install({
		"Mofiqul/vscode.nvim",
		cond = function()
			return false
		end,
		config = function()
			-- require("safdar.setup.ui.themes.config").vscode()
		end,
	})
	install({
		"shaunsingh/nord.nvim",
	})
end

return { install = themes }
