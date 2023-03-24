local function config()
	local ok, _ = pcall(require, "fused")
	if not ok then
		require("safdar.utils").notify("fused theme not loaded for nvim-tree")
	end

	local _, nvimtree = pcall(require, "nvim-tree")
	if not ok then
		require("safdar.utils").notify("nvim-tree not found")
		return
	end

	local maps = require("safdar.setup.navigation.nvim-tree.maps")

	nvimtree.setup({
		auto_reload_on_write = true,
		create_in_closed_folder = false,
		disable_netrw = false,
		hijack_cursor = true,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = true,
		open_on_tab = true,
		sort_by = "name",
		update_cwd = true,
		reload_on_bufenter = true,
		respect_buf_cwd = false,
		view = {
			adaptive_size = false,
			centralize_selection = false, -- dont turn this to true it gives error if you open file using other options rather then nvim-tree on startup like by using `nvim .` to open in the current directory
			width = 20,
			hide_root_folder = true,
			side = "right",
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "no",
			mappings = {
				custom_only = true,
				list = maps.nvim_tree_core_maps,
			},
		},
		notify = {
			threshold = vim.log.levels.WARN,
		},
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = false,
			full_name = false,
			highlight_opened_files = "none",
			root_folder_modifier = ":~",
			indent_markers = {
				enable = false,
				icons = {
					corner = "└ ",
					edge = "│ ",
					item = "│ ",
					none = "  ",
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", ".gitignore" },
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = { "terminal" },
		},
		system_open = {
			cmd = "",
			args = {},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filters = {
			dotfiles = true,
			custom = { "^node_modules", "package.json", "package-lock.json", "^.git" },
			exclude = {},
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 100,
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 400,
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			expand_all = {
				max_folder_discovery = 300,
			},
			open_file = {
				quit_on_open = true,
				resize_window = true,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = {
							"notify",
							"packer",
							"qf",
							"diff",
							"fugitive",
							"fugitiveblame",
						},
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = "gio trash",
			require_confirm = true,
		},
		live_filter = {
			prefix = "  : ",
			always_show_folders = false,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
	})

	maps.mappings()
end

return { config = config }
