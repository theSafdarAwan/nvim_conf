local config = function()
	require("gitsigns").setup({
		on_attach = require("safdar.setup.git.gitsigns.maps").mappings,
		sign_priority = 5,
		signs = {
			add = { hl = "DiffAdd", text = "┃", numhl = "GitSignsAddNr" },
			change = { hl = "DiffChange", text = "┃", numhl = "GitSignsChangeNr" },
			changedelete = {
				hl = "DiffChange",
				text = "┃",
				numhl = "GitSignsChangeNr",
			},
			-- delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
			delete = { hl = "DiffDelete", text = "━", numhl = "GitSignsDeleteNr" },
			topdelete = {
				lh = "DiffDelete",
				text = "▔",
				numhl = "GitSignsDeleteNr",
			},
		},

		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 100,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 500,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = " <author> 神<author_time:%d-%m-%Y>  <summary>",
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
	})
end

local setup = function()
	local vim = vim
	local gitsigns = {
		name = "gitsigns.nvim",
		on_load = {
			config = function()
				require("safdar.setup.git.gitsigns.config").config()
			end,
		},
		autocmd = {
			event = "BufRead",
			callback = function()
				vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
				if vim.v.shell_error == 0 then
					return true
				end
			end,
		},
	}
	require("lazy-loader").load(gitsigns)
end

return { config = config, setup = setup }
