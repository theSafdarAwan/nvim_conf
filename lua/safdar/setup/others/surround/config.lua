local function config()
	local ok, surround = pcall(require, "nvim-surround")
	if not ok then
		require("safdar.utils").notify("nvim-surround not found")
		return
	end

	surround.setup({
		keymaps = {
			insert = "<C-g>s",
			insert_line = "<C-g>S",
			normal = "ys",
			normal_cur = "ysl",
			normal_line = "ysL",
			normal_cur_line = "yss",
			visual = "S",
			visual_line = "SL",
			delete = "ds",
			change = "cs",
		},
		surrounds = {
			["("] = {
				add = { "(", ")" },
			},
			[")"] = {
				add = { "( ", " )" },
			},
			["{"] = {
				add = { "{", "}" },
			},
			["}"] = {
				add = { "{ ", " }" },
			},
			["["] = {
				add = { "[", "]" },
			},
			["]"] = {
				add = { "[ ", " ]" },
			},
		},
		aliases = {
			["j"] = "(",
			["k"] = "{",
			["l"] = "[",
			["q"] = { '"', "'", "`" },
			["s"] = { "{", "[", "(", "<", '"', "'", "`", " " },
		},
		move_cursor = false,
		indent_lines = false,
	})
end
return { config = config }
