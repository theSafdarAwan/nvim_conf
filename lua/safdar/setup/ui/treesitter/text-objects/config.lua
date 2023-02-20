local function config()
	-- TODO: what's going on here
	-- tj's config
	local swap_next, swap_prev = (function()
		local swap_objects = {
			p = "@parameter.inner",
			f = "@function.outer",
			e = "@element",

			-- Not ready, but I think it's my fault :)
			-- v = "@variable",
		}

		local n, p = {}, {}
		for key, obj in pairs(swap_objects) do
			n[string.format("<M-Space><M-%s>", key)] = obj
			p[string.format("<M-BS><M-%s>", key)] = obj
		end

		return n, p
	end)()

	require("nvim-treesitter.configs").setup({
		textobjects = {
			swap = {
				enable = true,
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
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["gnf"] = { query = "@function.outer", desc = "Next Function start" },
					["gnc"] = { query = "@class.outer", desc = "Next class start" },
					["gns"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
					["gni"] = { query = "@conditional.outer", desc = "Next Conditional start" },
					["gnl"] = { query = "@loop.outer", desc = "Next loop start" },
					["gnp"] = { query = "@parameter.inner", desc = "Next Parameter Start" },
					-- TODO: make it something like next function call or
					-- function definition
					-- ["]m"] = { query = "@function", desc = "Next function call Start" },
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
					["gpp"] = { query = "@parameter.inner", desc = "Previous Parameter Start" },
					-- ["[m"] = { query = "@function", desc = "Previous function call Start" },
				},
				goto_previous_end = {
					["gpF"] = { query = "@function.outer", desc = "Previous Function end" },
					["gpC"] = { query = "@class.outer", desc = "Previous Class end" },
					["gpI"] = { query = "@conditional.outer", desc = "Previous conditional end" },
				},
			},

			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select Function outer body" },
					["if"] = { query = "@function.inner", desc = "Select Function inner body" },

					["ac"] = { query = "@class.outer", desc = "Select Class outer body" },
					["ic"] = { query = "@class.inner", desc = "Select Class inner body" },

					["ai"] = {
						query = "@conditional.outer",
						desc = "Select Conditional outer body",
					},
					["ii"] = {
						query = "@conditional.inner",
						desc = "Select Conditional inner body",
					},

					["ap"] = { query = "@parameter.outer", desc = "Select Parameter Outer body" },
					["ip"] = { query = "@parameter.inner", desc = "Select Parameter Inner body" },

					["av"] = { query = "@variable.outer", desc = "Select variable outer body" },
					["iv"] = { query = "@variable.inner", desc = "Select variable inner body" },
				},
			},
		},
	})
end

return { config = config }
