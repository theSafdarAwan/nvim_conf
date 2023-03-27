local function config()
	local ok, lsp_saga = pcall(require, "lspsaga")
	if not ok then
		require("safdar.utils").notify("lspsaga-nvim.nvim not installed")
		return
	end
	lsp_saga.setup({
		ui = {
			theme = "round",
			border = "single",
			winblend = 0,
			expand = "",
			collapse = "",
			preview = " ",
			code_action = "",
			diagnostic = " ",
			incoming = " ",
			outgoing = " ",
			colors = {
				--float window normal bakcground color
				-- normal_bg = cp.bg,
				--title background color
				-- title_bg = cp.const,
				-- red = cp.err,
				-- magenta = cp.magenta,
				-- orange = cp.method,
				-- yellow = cp.warn,
				-- green = cp.search,
				-- cyan = cp.property,
				-- blue = cp.blue,
				-- purple = cp.lightpink,
				-- white = cp.white,
				-- black = cp.dark,
			},
			kind = {},
		},
		diagnostic = {
			twice_into = false,
			show_code_action = true,
			show_source = true,
			keys = {
				exec_action = "o",
				quit = "q",
				go_action = "g",
			},
		},
		code_action = {
			num_shortcut = true,
			keys = {
				quit = "q",
				exec = "<CR>",
			},
		},
		lightbulb = {
			enable = false,
			enable_in_insert = true,
			cache_code_action = false,
			sign = true,
			sign_priority = 20,
			virtual_text = true,
		},
		preview = {
			lines_above = 3,
			lines_below = 10,
		},
		scroll_preview = {
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},
		request_timeout = 2000,
		finder = {
			edit = { "o", "<CR>" },
			vsplit = "v",
			split = "s",
			tabe = "t",
			quit = { "q", "<ESC>" },
		},
		-- TODO: change these shortcuts
		definition = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>i",
			tabe = "<C-c>t",
			quit = "q",
			close = "<Esc>",
		},
		rename = {
			quit = "<C-c>",
			exec = "<CR>",
			in_select = true,
		},
		symbol_in_winbar = {
			enable = false,
			separator = " ",
			hide_keyword = true,
			show_file = true,
			folder_level = 2,
		},
		outline = {
			win_position = "right",
			win_with = "",
			win_width = 30,
			show_detail = true,
			auto_preview = true,
			auto_refresh = true,
			auto_close = true,
			custom_sort = nil,
			keys = {
				jump = "o",
				expand_collapse = "e",
				quit = "q",
			},
		},
		callhierarchy = {
			show_detail = false,
			keys = {
				edit = "e",
				vsplit = "s",
				split = "i",
				tabe = "t",
				jump = "o",
				quit = "q",
				expand_collapse = "e",
			},
		},
		server_filetype_map = {},
	})

	require("safdar.setup.lsp.lspsaga-nvim.maps")
end

return { config = config }
