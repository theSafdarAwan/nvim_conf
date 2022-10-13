require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.esupports.metagen"] = {
			config = {
				type = "auto",
			},
		},
		["core.integrations.nvim-cmp"] = {},
		["core.norg.concealer"] = {
			config = {
				icon_preset = "basic", -- diamond, varied
				-- If you want to dim code blocks
				dim_code_blocks = {
					enabled = true,
					content_only = true,
					width = "content",
					padding = {
						left = 0,
						right = 5,
					},
					conceal = true,
				},
				folds = false,
				icons = {
					todo = {
						on_hold = {
							enabled = true,
							icon = "",
							query = "(todo_item_on_hold) @icon",
							extract = function()
								return 1
							end,
						},
					},
					markup = {
						enabled = true,
						spoiler = {
							highlight = "TSError",
						},
					},
				},
			},
		},
	},
})
