local function plugin(install)
	install({
		"petertriho/nvim-scrollbar",
		lazy = false,
		config = function()
			local defaults = {}
			local diagnostics = {
				text = { "─", "═" },
			}

			require("scrollbar").setup({
				show_in_active_only = true,
				hide_if_all_visible = true, -- Hides everything if all lines are visible
				excluded_filetypes = {
					"prompt",
					"TelescopePrompt",
					"noice",
					"DressingInput",
					"NvimTree",
				},
				handle = {
					highlight = "PmenuSbar",
				},
				marks = {
					Cursor = { text = "─" },
					Error = diagnostics,
					Warn = diagnostics,
					Info = diagnostics,
					Hint = diagnostics,
				},
				max_lines = 2000, -- disables if no. of lines in buffer exceeds this
				autocmd = {
					render = {
						"BufWinEnter",
						"TabEnter",
						"TermEnter",
						"WinEnter",
						"CmdwinLeave",
						"TextChanged",
						"TextChangedI",
						"VimResized",
						"WinScrolled",
					},
					clear = {
						"BufWinLeave",
						"TabLeave",
						"TermLeave",
						"WinLeave",
					},
				},
			})
		end,
	})
end

return { install = plugin }
