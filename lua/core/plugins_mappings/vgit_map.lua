local M = {}
M.mappings = function()
	return {
        ['n <C-k>'] = 'hunk_up',
        ['n <C-j>'] = 'hunk_down',
		["n <leader>vs"] = "buffer_hunk_stage",
		["n <leader>vr"] = "buffer_hunk_reset",
        ['n <leader>vp'] = 'buffer_hunk_preview',
        ['n <leader>vH'] = 'project_hunks_preview',
		["n <leader>vi"] = "buffer_blame_preview",
		["n <leader>vd"] = "buffer_diff_preview",
		["n <leader>vh"] = "buffer_history_preview",
		["n <leader>vU"] = "buffer_reset",
		["n <leader>vb"] = "buffer_gutter_blame_preview",
		["n <leader>vP"] = "project_diff_preview",
		["n <leader>vx"] = "toggle_diff_preference",
        ['n <leader>vq'] = 'project_hunks_qf',
	}
end
return M
