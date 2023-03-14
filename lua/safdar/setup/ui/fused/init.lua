local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused not found")
			return
		end

		require("fused").setup({
			plugins_integration = false,
			override = function()
				return {
					["catppuccin-mocha"] = {
						builtin = {
						},
					},
				}
			end,
			custom = {
				-- DamianConway = { bg = colors.bg_windows2, styles = "bold,noitalic" },
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
