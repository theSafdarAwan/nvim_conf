local M = {}
M.mappings = function()
	return {
		["n <leader>va"] = "actions",
		["n <leader>vs"] = "buffer_hunk_stage",
		["n <leader>vr"] = "buffer_hunk_reset",
		["n <leader>vl"] = "buffer_blame_preview",
		["n <leader>vd"] = "buffer_diff_preview",
		["n <leader>vh"] = "buffer_history_preview",
		["n <leader>vU"] = "buffer_reset",
		["n <leader>vb"] = "buffer_gutter_blame_preview",
		["n <leader>vp"] = "project_diff_preview",
		["n <leader>vx"] = "toggle_diff_preference",
	}
end
return M
