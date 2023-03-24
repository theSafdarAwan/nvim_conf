local function config()
	local ok, ib = pcall(require, "indent_blankline")
	if not ok then
		require("safdar.utils").notify("indent-blankline.nvim not found")
		return
	end
	ib.setup({
		show_trailing_blankline_indent = false,
		show_first_indent_level = false,
		use_treesitter = true,
		indent_level = 4,
		show_current_context = true,
		space_char_blankline = " ",
		show_current_context_start = false,
		char = "│",
		-- char = "▏",
		-- char = "┃",
		buftype_exclude = { "terminal", "nofile", "nofile" },
		filetype_exclude = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
		},
	})
end

return { config = config }
