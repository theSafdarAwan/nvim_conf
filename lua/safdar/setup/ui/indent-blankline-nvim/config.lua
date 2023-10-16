local function config()
	local ok, ib = pcall(require, "ibl")
	if not ok then
		require("safdar.utils").notify("indent-blankline.nvim not installed")
		return
	end

	local highlight = {
		"@function",
		"@property",
		"@boolean",
		"@character",
	}

	require("ibl").setup({
		scope = {
			highlight = highlight,
			include = {
				-- node_type = { ["*"] = { "*" } },
			},
		},
		viewport_buffer = { min = 20, max = 100 },
		indent = {
			char = "▏",
		},
		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"packer",
				"neogitstatus",
				"NvimTree",
				"Trouble",
			},
			buftypes = {
				"terminal",
				"nofile",
			},
		},
	})
end

return { config = config }
