local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused not found")
			return
		end

		local hooks = {
			feline_config = function()
				package.loaded["feline"] = nil
				require("safdar.setup.ui.feline.config").config()
			end,
		}

		require("fused").setup({
			override = function()
				return {
					["catppuccin-mocha"] = {
						builtin = {},
					},
				}
			end,
			custom = {
				-- DamianConway = { bg = colors.bg_windows2, styles = "bold,noitalic" },
			},
		})
		require("fused").add_hooks(hooks)
	end

	install({
		"TheSafdarAwan/fused.nvim",
		lazy = false,
		branch = "re-write",
		config = config,
	})
end

return { install = fused }
