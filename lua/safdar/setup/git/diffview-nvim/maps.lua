local M = {}
local actions = require("diffview.actions")

M.maps = function()
	local utils = require("safdar.utils")
	local set_map = utils.set_map

	set_map("n", "ygd", "<cmd>DiffviewOpen<CR>")
	set_map("n", "ygD", "<cmd>DiffviewFileHistory<CR>")
	set_map("n", "ygx", "<cmd>DiffviewClose<CR>")
	print("hi")
end

M.keymaps = {}

M.keymaps.view = {
	["J"] = actions.select_next_entry,
	["K"] = actions.select_prev_entry,
	["<C-w>go"] = actions.goto_file_split,
	["go"] = actions.goto_file_tab,
	["E"] = actions.focus_files,
	["T"] = actions.toggle_files,
	["cL"] = actions.cycle_layout,
	["[x"] = actions.prev_conflict,
	["]x"] = actions.next_conflict,
	["<space>co"] = actions.conflict_choose("ours"),
	["<space>ct"] = actions.conflict_choose("theirs"),
	["<space>cb"] = actions.conflict_choose("base"),
	["<space>ca"] = actions.conflict_choose("all"),
	["<space>cn"] = actions.conflict_choose("none"),
}
M.keymaps.diff3 = {
	{ { "n", "x" }, "2do", actions.diffget("ours") },
	{ { "n", "x" }, "3do", actions.diffget("theirs") },
}
M.keymaps.diff4 = {
	{ { "n", "x" }, "1do", actions.diffget("base") },
	{ { "n", "x" }, "2do", actions.diffget("ours") },
	{ { "n", "x" }, "3do", actions.diffget("theirs") },
}
M.keymaps.file_panel = {
	["j"] = actions.next_entry,
	["k"] = actions.prev_entry,
	["<tab>"] = actions.select_entry,
	["-"] = actions.toggle_stage_entry,
	["<C-s>"] = actions.stage_all,
	["U"] = actions.unstage_all,
	["X"] = actions.restore_entry,
	["L"] = actions.open_commit_log,
	["<c-b>"] = actions.scroll_view(-0.25),
	["<c-f>"] = actions.scroll_view(0.25),
	["J"] = actions.select_next_entry,
	["K"] = actions.select_prev_entry,
	["<C-w>go"] = actions.goto_file_split,
	["go"] = actions.goto_file_tab,
	["i"] = actions.listing_style,
	["f"] = actions.toggle_flatten_dirs,
	["R"] = actions.refresh_files,
	["E"] = actions.focus_files,
	["T"] = actions.toggle_files,
	["cL"] = actions.cycle_layout,
	["[x"] = actions.prev_conflict,
	["]x"] = actions.next_conflict,
}
M.keymaps.file_history_panel = {
	["g!"] = actions.options,
	["<C-A-d>"] = actions.open_in_diffview,
	["y"] = actions.copy_hash,
	["L"] = actions.open_commit_log,
	["zr"] = actions.open_all_folds,
	["zm"] = actions.close_all_folds,
	["j"] = actions.next_entry,
	["k"] = actions.prev_entry,
	["<tab>"] = actions.select_entry,
	["<c-b>"] = actions.scroll_view(-0.25),
	["<c-f>"] = actions.scroll_view(0.25),
	["J"] = actions.select_next_entry,
	["K"] = actions.select_prev_entry,
	["<C-w>go"] = actions.goto_file_split,
	["go"] = actions.goto_file_tab,
	["E"] = actions.focus_files,
	["T"] = actions.toggle_files,
	["cL"] = actions.cycle_layout,
}
M.keymaps.option_panel = {
	["<tab>"] = actions.select_entry,
	["q"] = actions.close,
}

return M
