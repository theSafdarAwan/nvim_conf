local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused not found")
			return
		end
		-- @colorsjrequire the fused color pallete
		local cp = require("fused.pallets.dark").pallete

		require("fused").setup({
			-- flavour = "dark",
			flavour = "catppuccin",
			-- flavour = "aquarium",
			-- flavour = "onedark",
			plugins_integration = false,
			custom = {
				DamianConway = { bg = cp.cp0 },
			},
		})
	end

	install({
		"TheSafdarAwan/fused.nvim",
		config = config,
	})
end

return { install = fused }
