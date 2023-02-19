local function config()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			swap = {
				swap_next = {
					["gsn"] = {
						query = "@parameter.inner",
						desc = "Swap current parameter with next parameter",
					},
				},
				swap_previous = {
					["gsp"] = {
						query = "@parameter.inner",
						desc = "Swap current parameter with previous parameter",
					},
				},
			},
			move = {
				set_jumps = true,
				goto_next_start = {
					["gnf"] = { query = "@function.outer", desc = "Next Function start" },
					["gnc"] = { query = "@class.outer", desc = "Next class start" },
					["gns"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
					["gni"] = { query = "@conditional.outer", desc = "Next Conditional start" },
					["gnl"] = { query = "@loop.outer", desc = "Next loop start" },
				},
				goto_next_end = {
					["gnF"] = { query = "@function.outer", desc = "Next Function end" },
					["gnC"] = { query = "@class.outer", desc = "Next Class end" },
					["gnI"] = { query = "@conditional.outer", desc = "Next Conditional end" },
					["gnL"] = { query = "@loop.outer", desc = "Next loop end" },
				},
				goto_previous_start = {
					["gpf"] = { query = "@function.outer", desc = "Previous Function start" },
					["gpc"] = { query = "@class.outer", desc = "Previous Class start" },
					["gpi"] = { query = "@conditional.outer", desc = "Previous Conditional start" },
				},
				goto_previous_end = {
					["gpF"] = { query = "@function.outer", desc = "Previous Function end" },
					["gpC"] = { query = "@class.outer", desc = "Previous Class end" },
					["gpI"] = { query = "@conditional.outer", desc = "Previous conditional end" },
				},
			},
		},
	})
end

return { config = config }
