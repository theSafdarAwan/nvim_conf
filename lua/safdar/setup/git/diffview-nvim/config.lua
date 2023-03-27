local function config()
	local ok, diffview = pcall(require, "diffview")
	if not ok then
		require("safdar.utils").notify("diffview.nvim not installed")
	end

	local mappings = require("safdar.setup.git.diffview-nvim.maps")

	diffview.setup({
		diff_binaries = false,
		enhanced_diff_hl = true,
		git_cmd = { "git" },
		use_icons = true,
		watch_index = true,
		icons = {
			folder_closed = "",
			folder_open = "",
		},
		signs = {
			fold_closed = "",
			fold_open = "",
			done = "✓",
		},
		view = {
			default = {
				layout = "diff2_horizontal",
			},
			merge_tool = {
				layout = "diff4_mixed",
				disable_diagnostics = true,
			},
			file_history = {
				layout = "diff2_horizontal",
			},
		},
		file_panel = {
			listing_style = "list",
			tree_options = {
				flatten_dirs = true,
				folder_statuses = "only_folded",
			},
			win_config = {
				position = "bottom",
				height = 12,
				win_opts = {},
			},
		},
		file_history_panel = {
			log_options = {
				git = {
					single_file = {
						diff_merges = "combined",
					},
					multi_file = {
						diff_merges = "first-parent",
					},
				},
			},
			win_config = {
				position = "bottom",
				height = 12,
				win_opts = {},
			},
		},
		commit_log_panel = {
			win_config = {
				height = 16,
				win_opts = {},
			},
		},
		default_args = {
			DiffviewOpen = {},
			DiffviewFileHistory = {},
		},
		hooks = {},
		keymaps = {
			disable_defaults = true,
			view = mappings.keymaps.view,
			diff1 = {},
			diff2 = {},
			diff3 = mappings.keymaps.diff3,
			diff4 = mappings.keymaps.diff4,
			file_panel = mappings.keymaps.file_panel,
			file_history_panel = mappings.keymaps.file_history_panel,
			option_panel = mappings.keymaps.option_panel,
		},
	})

	mappings.maps()
end

return { config = config }
