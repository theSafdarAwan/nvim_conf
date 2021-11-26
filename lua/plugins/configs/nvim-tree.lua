local vim = vim
local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_gitignore = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0
g.nvim_tree_git_hl = 0
g.nvim_tree_group_empty = 1
g.nvim_tree_disable_window_picker = 0
g.nvim_tree_create_in_closed_folder = 0
g.nvim_tree_refresh_wait = 500
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })
g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		deleted = "",
		ignored = "◌",
		renamed = "➜",
		staged = "✓",
		unmerged = "",
		unstaged = "✗",
		untracked = "★",
	},
	folder = {
		-- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
		-- arrow_open = "",
		-- arrow_closed = "",
		default = "",
		empty = "", -- 
		empty_open = "",
		open = "",
		symlink = "",
		symlink_open = "",
	},
}
g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}
require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = true,
	ignore_ft_on_setup = { "dashboard" },
	auto_close = false,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	git = false,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	filters = {
		dotfiles = true,
		custom = { "node_modules", "package.json", "package-lock.json", ".git" },
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "right",
		auto_resize = true,
	},
})
