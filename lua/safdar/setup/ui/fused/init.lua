local fused = function(install)
	local config = function()
		local ok, _ = pcall(require, "fused")
		if not ok then
			require("safdar.utils").notify("fused.nvim not installed")
			return
		end

		local hooks = {
			feline_config = function()
				package.loaded["feline"] = nil
				require("safdar.setup.ui.feline.config").config()
			end,
		}

		require("fused").setup({
			settings = {
				custom_hl = function(cp)
					local colors = {
						CustomColorColumn = { bg = cp.base01 },
						SlimNormalFloat = { bg = cp.base19 },
					}
					return colors
				end,
			},
		})
		require("fused").add_hooks(hooks)
	end

	install({
		"TheSafdarAwan/fused.nvim",
		lazy = false,
		branch = "improving/plugins",
		config = config,
	})
end

return { install = fused }
