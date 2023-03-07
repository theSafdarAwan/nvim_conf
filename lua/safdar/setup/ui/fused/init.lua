local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused not found")
			return
		end
		--- table of colors
		--- @table colors
		local colors = require("fused.utils").colors

		require("fused").setup({
			-- flavour = "dark",
			flavour = "catppuccin",
			-- flavour = "aquarium",
			-- flavour = "onedark",
			plugins_integration = false,
			custom = {
				DamianConway = { bg = colors.bg_windows2, styles = "bold,noitalic" },
			},
		})
	end

	install({
		"TheSafdarAwan/fused.nvim",
		branch = "re-write",
		config = config,
	})
end

return { install = fused }
