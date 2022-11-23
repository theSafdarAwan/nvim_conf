local map = require("safdar.core.utils").map

local M = {}

M.mappings = function()
	map("n", "<leader>vet", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
end

M.nvim_tree_core_maps = {
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	{ key = "<C-e>", action = "edit_in_place" },
	{ key = "O", action = "edit_no_picker" },
	{ key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
	{ key = "<C-v>", action = "vsplit" },
	{ key = "<C-x>", action = "split" },
	{ key = "<C-t>", action = "tabnew" },
	{ key = "K", action = "prev_sibling" },
	{ key = "J", action = "next_sibling" },
	{ key = "P", action = "parent_node" },
	{ key = "<BS>", action = "close_node" },
	{ key = "<Tab>", action = "preview" },
	{ key = "<", action = "first_sibling" },
	{ key = ">", action = "last_sibling" },
	{ key = "I", action = "toggle_git_ignored" },
	{ key = "H", action = "toggle_dotfiles" },
	{ key = "U", action = "toggle_custom" },
	{ key = "R", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "D", action = "remove" },
	{ key = "d", action = "trash" },
	{ key = "r", action = "rename" },
	{ key = "<C-r>", action = "full_rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "y", action = "copy_name" },
	{ key = "Y", action = "copy_path" },
	{ key = "gy", action = "copy_absolute_path" },
	{ key = "gk", action = "prev_diag_item" },
	{ key = "gk", action = "prev_git_item" },
	{ key = "gj", action = "next_diag_item" },
	{ key = "gj", action = "next_git_item" },
	{ key = "-", action = "dir_up" },
	-- { key = "", action = "system_open" },
	{ key = "s", action = "live_filter" },
	{ key = "S", action = "clear_live_filter" },
	{ key = "q", action = "close" },
	{ key = "E", action = "collapse_all" },
	{ key = "e", action = "expand_all" },
	{ key = "f", action = "search_node" },
	{ key = "!", action = "run_file_command" },
	{ key = "<C-k>", action = "toggle_file_info" },
	{ key = "g?", action = "toggle_help" },
	{ key = "m", action = "toggle_mark" },
	{ key = "bmv", action = "bulk_move" },
}

return M
