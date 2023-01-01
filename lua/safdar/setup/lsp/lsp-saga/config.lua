local function config()
	local ok, lsp_saga = pcall(require, "lspsaga")
	if not ok then
		require("safdar.utils").notify("lsp-saga.nvim not found")
		return
	end
	lsp_saga.init_lsp_saga({
		-- Options with default value
		-- "single" | "double" | "rounded" | "bold" | "plus"
		border_style = "single",
		--the range of 0 for fully opaque window (disabled) to 100 for fully
		--transparent background. Values between 0-30 are typically most useful.
		saga_winblend = 0,
		-- when cursor in saga window you config these to move
		move_in_saga = { prev = "<C-p>", next = "<C-n>" },
		-- Error, Warn, Info, Hint
		-- use emoji like
		-- { "🙀", "😿", "😾", "😺" }
		-- or
		-- { "😡", "😥", "😤", "😐" }
		-- and diagnostic_header can be a function type
		-- must return a string and when diagnostic_header
		-- is function type it will have a param `entry`
		-- entry is a table type has these filed
		-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
		diagnostic_header = { "  ", "  ", "  ", "  " },
		-- preview lines of lsp_finder and definition preview
		max_preview_lines = 30,
		-- use emoji lightbulb in default
		code_action_icon = " ",
		-- if true can press number to execute the codeaction in codeaction window
		code_action_num_shortcut = true,
		-- same as nvim-lightbulb but async
		code_action_lightbulb = {
			enable = false,
			enable_in_insert = false,
			cache_code_action = true,
			sign = false,
			update_time = 500,
			sign_priority = 20,
			virtual_text = true,
		},
		-- finder icons
		finder_icons = {
			def = "  ",
			ref = "諭 ",
			link = "  ",
		},
		-- finder do lsp request timeout
		-- if your project big enough or your server very slow
		-- you may need to increase this value
		finder_request_timeout = 1500,
		finder_action_keys = {
			open = { "o", "<CR>" },
			vsplit = "v",
			split = "s",
			tabe = "t",
			quit = { "q", "<ESC>" },
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>",
		},
		definition_action_keys = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>s",
			tabe = "<C-c>t",
			quit = "q",
		},
		rename_action_quit = "<C-c>",
		rename_in_select = true,
		-- show symbols in winbar must nightly
		-- in_custom mean use lspsaga api to get symbols
		-- and set it to your custom winbar or some winbar plugins.
		-- if in_cusomt = true you must set in_enable to false
		symbol_in_winbar = {
			in_custom = false,
			enable = false,
			separator = " ",
			show_file = true,
			-- define how to customize filename, eg: %:., %
			-- if not set, use default value `%:t`
			-- more information see `vim.fn.expand` or `expand`
			-- ## only valid after set `show_file = true`
			file_formatter = "",
			click_support = false,
		},
		-- show outline
		show_outline = {
			win_position = "right",
			--set special filetype win that outline window split.like NvimTree neotree
			-- defx, db_ui
			win_with = "",
			win_width = 30,
			auto_enter = true,
			auto_preview = true,
			virt_text = "┃",
			jump_key = "o",
			-- auto refresh when change buffer
			auto_refresh = true,
		},
		-- custom lsp kind
		-- usage { Field = 'color code'} or {Field = {your icon, your color code}}
		custom_kind = {},
		-- if you don't use nvim-lspconfig you must pass your server name and
		-- the related filetypes into this table
		-- like server_filetype_map = { metals = { "sbt", "scala" } }
		server_filetype_map = {},
	})

	require("safdar.setup.lsp.lsp-saga.maps")
end

return { config = config }