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
					["gpl"] = { query = "@loop.outer", desc = "Previous loop start" },
					-- ["[m"] = { query = "@function", desc = "Previous function call Start" },
				},
				goto_previous_end = {
					["gpF"] = { query = "@function.outer", desc = "Previous Function end" },
					["gpC"] = { query = "@class.outer", desc = "Previous Class end" },
					["gpI"] = { query = "@conditional.outer", desc = "Previous conditional end" },
					["gpL"] = { query = "@loop.outer", desc = "Previous loop end" },
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

					["aa"] = { query = "@parameter.outer", desc = "Select Parameter Outer body" },
					["ia"] = { query = "@parameter.inner", desc = "Select Parameter Inner body" },

					["av"] = { query = "@variable.outer", desc = "Select variable outer body" },
					["iv"] = { query = "@variable.inner", desc = "Select variable inner body" },
				},
			},
		},
	})

	local map_opts = { noremap = true, silent = true }

	-- extend the text-objects to delete/change
	---@param extended_key string key c/d
	---@param callback function function to remap the extended_key with after
	--- text manipulation.
	local function text_manipulation_text_objects(extended_key, callback)
		local fn = vim.fn

		-- to go to default `d` key
		vim.keymap.set("n", extended_key, extended_key, map_opts)

		local chars = ""
		-- to add timeout
		local timeout = vim.opt.timeoutlen._value
		-- i variable acts as a id identifier to not let the previous loop
		-- iteration feedkeys affect the current one.
		local i = 0
		while true do
			i = i + 1
			local id = i
			vim.defer_fn(function()
				if i == id and fn.mode() ~= "i" then
					-- to get rid of the getchar will throw dummy value which won't
					-- be added to the chars list
					vim.api.nvim_feedkeys("�", "n", false)
				end
			end, timeout)

			local c = fn.getchar()
			if type(c) ~= "number" or c < 65 or c > 127 then
				return
			end
			chars = chars .. fn.nr2char(c)
			if #chars == 2 then
				break
			end
			if #chars == 1 and c ~= 97 and c ~= 105 then
				vim.api.nvim_feedkeys(extended_key .. chars, "t", false)
				return
			end
		end

		vim.api.nvim_feedkeys("v" .. chars .. extended_key, "t", false)

		vim.keymap.set("n", extended_key, function()
			callback(extended_key, callback)
		end)
	end

	vim.defer_fn(function()
		local extended_keys = { "d", "c" }
		for _, key in ipairs(extended_keys) do
			vim.keymap.set("n", key, function()
				text_manipulation_text_objects(key, text_manipulation_text_objects)
			end, map_opts)
		end
	end, 0)
end

return { config = config }
