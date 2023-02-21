local function config()
	local maps = require("safdar.setup.others.nvim-spectre.maps")
	require("spectre").setup({
		open_cmd = "bn",
		live_update = true, -- auto execute search again when you write any file in vim
		mapping = maps.spectre_maps(),
		replace_vim_cmd = "cdo",
		is_open_target_win = true, --open file on opener window
		is_insert_mode = true, -- start open panel on is_insert_mode
	})
end
return { config = config }
