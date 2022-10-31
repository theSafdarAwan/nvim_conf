-----------------------
--  git sigs plugin  --
-----------------------

require("gitsigns").setup({
	-- TODO: work on this
	-- on_attach = function(bufnr)
	--     local gs = package.loaded.gitsigns
	--
	--     local function map(mode, l, r, opts)
	--         opts = opts or {}
	--         opts.buffer = bufnr
	--         vim.keymap.set(mode, l, r, opts)
	--     end
	--
	--     -- Navigation
	--     map("n", "]c", function()
	--         if vim.wo.diff then
	--             return "]c"
	--         end
	--         vim.schedule(function()
	--             gs.next_hunk()
	--         end)
	--         return "<Ignore>"
	--     end, { expr = true })
	--
	--     map("n", "[c", function()
	--         if vim.wo.diff then
	--             return "[c"
	--         end
	--         vim.schedule(function()
	--             gs.prev_hunk()
	--         end)
	--         return "<Ignore>"
	--     end, { expr = true })
	--
	--     -- Actions
	--     map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
	--     map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
	--     map("n", "<leader>hS", gs.stage_buffer)
	--     map("n", "<leader>hu", gs.undo_stage_hunk)
	--     map("n", "<leader>hR", gs.reset_buffer)
	--     map("n", "<leader>hp", gs.preview_hunk)
	--     map("n", "<leader>hb", function()
	--         gs.blame_line({ full = true })
	--     end)
	--     map("n", "<leader>tb", gs.toggle_current_line_blame)
	--     map("n", "<leader>hd", gs.diffthis)
	--     map("n", "<leader>hD", function()
	--         gs.diffthis("~")
	--     end)
	--     map("n", "<leader>td", gs.toggle_deleted)
	--
	--     -- Text object
	--     map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	-- end,
	keymaps = {
		-- Default keymap options
		buffer = true,
		noremap = true,
		["n gj"] = {
			expr = true,
			"&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
		},
		["n gk"] = {
			expr = true,
			"&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
		},
		["n gcs"] = "<cmd>lua require\"gitsigns\".stage_hunk()<CR>",
		["n gcu"] = "<cmd>lua require\"gitsigns\".undo_stage_hunk()<CR>",
		["n gcr"] = "<cmd>lua require\"gitsigns\".reset_hunk()<CR>",
		["n gcp"] = "<cmd>lua require\"gitsigns\".preview_hunk()<CR>",
		["n gbs"] = ":Gitsigns stage_buffer<cr>",
		["n gbr"] = ":Gitsigns reset_buffer<cr>",
	},
	sign_priority = 5,
	signs = {
		add = { hl = "DiffAdd", text = "┃", numhl = "GitSignsAddNr" },
		change = { hl = "DiffChange", text = "┃", numhl = "GitSignsChangeNr" },
		changedelete = {
			hl = "DiffChange",
			text = "┃",
			numhl = "GitSignsChangeNr",
		},
		delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
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
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
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
