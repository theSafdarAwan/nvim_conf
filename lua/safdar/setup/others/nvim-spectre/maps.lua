local maps = function()
	local set_map = require("safdar.utils").set_map
	local map_opts = require("safdar.utils").map_options
	set_map(
		"n",
		"=r",
		":lua require('spectre').open()<CR>",
		map_opts:new():silent():noremap():desc("Open spectre in a new buffer")
	)
	set_map(
		"v",
		"=r",
		":lua require('spectre').open_visual()<CR>",
		map_opts:new():silent():noremap():desc("Open spectre in visual mode in new buffer")
	)
	set_map(
		"n",
		"=u",
		":lua require('spectre').open_visual({select_word=true})<CR>",
		map_opts:new():silent():noremap():desc("Open spectre with current word under cursor as pattern")
	)
	set_map(
		"n",
		"=f",
		":lua require('spectre').open_file_search()<CR>",
		map_opts:new():silent():noremap():desc("Open spectre with constraint to current file only")
	)
end
local spectre_maps = function()
	return {
		["toggle_line"] = {
			map = "T",
			cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
			desc = "Spectre: toggle current item",
		},
		["enter_file"] = {
			map = "<cr>",
			cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
			desc = "Spectre: goto current file",
		},
		["send_to_qf"] = {
			map = "=q",
			cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
			desc = "Spectre: send all item to quickfix",
		},
		["replace_cmd"] = {
			map = "=y",
			cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
			desc = "Spectre: input replace vim command",
		},
		["run_current_replace"] = {
			map = "=rc",
			cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
			desc = "Spectre: replace current line",
		},
		["run_replace"] = {
			map = "=Y",
			cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
			desc = "Spectre: replace all",
		},
		["show_option_menu"] = {
			map = "=sm",
			cmd = "<cmd>lua require('spectre').show_options()<CR>",
			desc = "Spectre: show option",
		},
		["change_view_mode"] = {
			map = "=sv",
			cmd = "<cmd>lua require('spectre').change_view()<CR>",
			desc = "Spectre: change result view mode",
		},
		["toggle_live_update"] = {
			map = "=sl",
			cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
			desc = "Spectre: update change when vim write file.",
		},
		["toggle_ignore_case"] = {
			map = "=sc",
			cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
			desc = "Spectre: toggle ignore case",
		},
		["toggle_ignore_hidden"] = {
			map = "=sh",
			cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
			desc = "Spectre: toggle search hidden",
		},
		["resume_last_search"] = {
			map = "=ll",
			cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
			desc = "Spectre: resume last search before close when in the spectre buffer",
		},
		-- you can put your mapping here it only use normal mode
	}
end

return { spectre_maps = spectre_maps, maps = maps }
