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
				---@type table there are four options available for setting globally.
				global = {
					---@type string|table global style for all flavours. Has less precedence
					--- then the {flavour}.style
					style = "slim",
					---@type boolean enable italics for theme.
					italics = true,
					---@type boolean set background to transparent
					background_transparent = false,
					---@type boolean use the theme colors for the terminal colors
					terminal_colors = true,
				},
				---@type table setting for individual theme flavour there are
				["tokyonight-storm"] = {
					---@type string|table style string for flavour or table with
					--- individual plugin style.
					style = "slim",
					style_groups = {
						["nvim-notify"] = "bordered",
					},
					---@type function|table override the default highlights if function should
					--- return a table
					---@param colors table|function colors table for the flavour
					override_hl = function(colors)
						return {
							["telescope.nvim"] = {},
							syntax = {},
							editor = {},
							lsp = {},
						}
					end,
					override_style = function(colors)
						return {
							slim = {},
						}
					end,
				},
				custom_hl = function(cp)
					local colors = {
						CustomColorColumn = { bg = cp.base01 },
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
		branch = "tokyonight-storm",
		config = config,
	})
end

return { install = fused }
