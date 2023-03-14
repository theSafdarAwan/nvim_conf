local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused not found")
			return
		end
		-- to get current line number different than other line number
		vim.cmd("set cursorline")

		require("fused").setup({
			plugins_integration = false,
			override = function()
				return {
					["catppuccin-mocha"] = {
						builtin = {
							LineNr = { fg = "#44475a" },
							CursorLineNr = { fg = "#abb2bf" },
							CursorLine = { bg = "#1E1E2E" },
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
