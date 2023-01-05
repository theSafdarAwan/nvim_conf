local function themes(install)
	install({
		opt = true,
		after = "fused.nvim",
		"ellisonleao/gruvbox.nvim",
	})
	install({
		opt = true,
		after = "gruvbox.nvim",
		"catppuccin/nvim",
	})
	install({
		opt = true,
		"LunarVim/Colorschemes",
		after = "gruvbox.nvim",
	})
	install({
		opt = true,
		"nvchad/base46",
		after = "Colorschemes",
		config = function()
			-- local base46 = require("base46")
			-- base46.load_theme()
			-- base46.load_highlight("treesitter")
		end,
	})
	install({
		opt = true,
		"folke/tokyonight.nvim",
		after = "base46",
		config = function()
			-- require("safdar.setup.ui.themes.config").tokyonight()
		end,
	})
	install({
		opt = true,
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
		opt = true,
		after = "vscode.nvim",
		"shaunsingh/nord.nvim",
	})
end

return { install = themes }
