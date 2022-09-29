local colors = require("lua.safdar.lush_theme.dracula-pallete")
-- vim.cmd [[packadd nvim-treesitter]]

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"python",
		"typescript",
		"javascript",
		"css",
		"markdown",
		"rust",
		"go",
		"html",
		"json",
		"scss",
	},
	highlight = {
		enable = true,
		-- disable = function(lang, bufnr)
		-- 	return lang == "lua" and vim.api.nvim_buf_line_count(bufnr) > 100
		-- end,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = false,
	},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
	rainbow = {
		enable = true,
		disable = { "html", "md" },
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- termcolors = {},-- table of colour name strings
		colors = {
			colors.rts_1,
			colors.rts_2,
			colors.rts_3,
			colors.rts_4,
			colors.rts_5,
		}, -- table of hex strings
	},
	context_commentstring = {
		enable = true,
	},
})
