local function themes(install)
	install({
		after = "fused.nvim",
		"ellisonleao/gruvbox.nvim",
	})
	install({
		after = "gruvbox.nvim",
		"catppuccin/nvim",
	})
	install({
		"LunarVim/Colorschemes",
		after = "gruvbox.nvim",
	})
	install({
		"nvchad/base46",
		after = "Colorschemes",
		config = function()
			-- local base46 = require("base46")
			-- base46.load_theme()
			-- base46.load_highlight("treesitter")
		end,
	})
	install({
		"folke/tokyonight.nvim",
		after = "base46",
		config = function()
			-- require("safdar.setup.ui.themes.config").tokyonight()
		end,
	})
	install({
		"Mofiqul/vscode.nvim",
		after = "tokyonight.nvim",
		cond = function()
			return false
		end,
		config = function()
			-- require("safdar.setup.ui.themes.config").vscode()
		end,
	})
	install({
		after = "vscode.nvim",
		"shaunsingh/nord.nvim",
	})
end

return { install = themes }
