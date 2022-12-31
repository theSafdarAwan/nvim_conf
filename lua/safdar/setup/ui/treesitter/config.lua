local config = function()
	local ok, _ = pcall(require, "nvim-treesitter")
	if not ok then
		require("safdar.utils").notify("treesitter not found")
		return
	end

	local vim = vim

	local ts_maps = require("safdar.setup.ui.treesitter.maps").treesitter_maps

	-- vim.cmd [[packadd nvim-treesitter]]

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
		-- A list of parser names, or "all"
		ensure_installed = {
			"lua",
			"vim",
			"python",
			"bash",
			"norg",
			"latex",
			"typescript",
			"javascript",
			"css",
			"markdown",
			"rust",
			"query",
			"go",
			"html",
			"json",
			"scss",
			"gitcommit",
			"gitattributes",
			"git_rebase",
		},
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = true,
		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,
		highlight = {
			enable = true,
			-- to disable slow treesitter highlight for large files
			disable = function(lang, buf)
				local max_filesize = 1000 * 1024 -- to disable in a file large then this size in KB 100 * 1024 means 100 kb
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = ts_maps,
		},
		rainbow = {
			enable = true,
			disable = { "html", "md", "norg" },
			extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- termcolors = {}, -- table of colour name strings
			-- colors = {}, -- table of hex strings
		},
		context_commentstring = {
			enable = true,
		},

		textobjects = {
			move = {
				enable = true,
				set_jumps = true,

				goto_next_start = {
					["]p"] = "@parameter.inner",
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[p"] = "@parameter.inner",
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},

			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",

					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",

					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",

					["av"] = "@variable.outer",
					["iv"] = "@variable.inner",
				},
			},

			swap = {
				enable = true,
				swap_next = swap_next,
				swap_previous = swap_prev,
			},
		},
	})
	-- local _ = require("nvim-treesitter.configs").setup {
	--   ensure_installed = {
	--     "go",
	--     "html",
	--     "javascript",
	--     "json",
	--     "markdown",
	--     "python",
	--     "query",
	--     "racket",
	--     "rust",
	--     "toml",
	--     "tsx",
	--     "typescript",
	--   },
	--
	--   highlight = {
	--     enable = true,
	--     use_languagetree = false,
	--     -- disable = { "json" },
	--     custom_captures = custom_captures,
	--   },
	--
	--   refactor = {
	--     highlight_definitions = { enable = true },
	--     highlight_current_scope = { enable = false },
	--
	--     smart_rename = {
	--       enable = false,
	--       keymaps = {
	--         -- mapping to rename reference under cursor
	--         smart_rename = "grr",
	--       },
	--     },
	--
	--     navigation = {
	--       enable = false,
	--       keymaps = {
	--         goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
	--         list_definitions = "gnD", -- mapping to list all definitions in current file
	--       },
	--     },
	--   },
	--
	--   incremental_selection = {
	--     enable = true,
	--     keymaps = {
	--       init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
	--       node_incremental = "<M-w>", -- increment to the upper named parent
	--       node_decremental = "<M-C-w>", -- decrement to the previous node
	--       scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
	--     },
	--   },
	--
	--   context_commentstring = {
	--     enable = true,
	--
	--     -- With Comment.nvim, we don't need to run this on the autocmd.
	--     -- Only run it in pre-hook
	--     enable_autocmd = false,
	--
	--     config = {
	--       c = "// %s",
	--       lua = "-- %s",
	--     },
	--   },
	--
	--   textobjects = {
	--     move = {
	--       enable = true,
	--       set_jumps = true,
	--
	--       goto_next_start = {
	--         ["]p"] = "@parameter.inner",
	--         ["]m"] = "@function.outer",
	--         ["]]"] = "@class.outer",
	--       },
	--       goto_next_end = {
	--         ["]M"] = "@function.outer",
	--         ["]["] = "@class.outer",
	--       },
	--       goto_previous_start = {
	--         ["[p"] = "@parameter.inner",
	--         ["[m"] = "@function.outer",
	--         ["[["] = "@class.outer",
	--       },
	--       goto_previous_end = {
	--         ["[M"] = "@function.outer",
	--         ["[]"] = "@class.outer",
	--       },
	--     },
	--
	--     select = {
	--       enable = true,
	--       keymaps = {
	--         ["af"] = "@function.outer",
	--         ["if"] = "@function.inner",
	--
	--         ["ac"] = "@conditional.outer",
	--         ["ic"] = "@conditional.inner",
	--
	--         ["aa"] = "@parameter.outer",
	--         ["ia"] = "@parameter.inner",
	--
	--         ["av"] = "@variable.outer",
	--         ["iv"] = "@variable.inner",
	--       },
	--     },
	--
	--     swap = {
	--       enable = true,
	--       swap_next = swap_next,
	--       swap_previous = swap_prev,
	--     },
	--   },
	--
	--   playground = {
	--     enable = true,
	--     updatetime = 25,
	--     persist_queries = true,
	--     keybindings = {
	--       toggle_query_editor = "o",
	--       toggle_hl_groups = "i",
	--       toggle_injected_languages = "t",
	--
	--       -- This shows stuff like literal strings, commas, etc.
	--       toggle_anonymous_nodes = "a",
	--       toggle_language_display = "I",
	--       focus_language = "f",
	--       unfocus_language = "F",
	--       update = "R",
	--       goto_node = "<cr>",
	--       show_help = "?",
	--     },
	--   },
	-- }
	--

	require("safdar.setup.ui.treesitter.maps")
end
return { config = config }
