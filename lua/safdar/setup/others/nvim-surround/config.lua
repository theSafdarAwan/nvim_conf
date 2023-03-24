local function config()
	local ok, surround = pcall(require, "nvim-surround")
	if not ok then
		require("safdar.utils").notify("nvim-surround not found")
		return
	end

	local surround_config = require("nvim-surround.config")

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
				find = function()
					return surround_config.get_selection({ motion = "a(" })
				end,
				delete = "^(. ?)().-( ?.)()$",
			},
			[")"] = {
				add = { "( ", " )" },
				find = function()
					return surround_config.get_selection({ motion = "a)" })
				end,
				delete = "^(.)().-(.)()$",
			},
			["{"] = {
				add = { "{", "}" },
				find = function()
					return surround_config.get_selection({ motion = "a{" })
				end,
				delete = "^(. ?)().-( ?.)()$",
			},
			["}"] = {
				add = { "{ ", " }" },
				find = function()
					return surround_config.get_selection({ motion = "a}" })
				end,
				delete = "^(.)().-(.)()$",
			},
			["<"] = {
				add = { "<", ">" },
				find = function()
					return surround_config.get_selection({ motion = "a<" })
				end,
				delete = "^(. ?)().-( ?.)()$",
			},
			[">"] = {
				add = { "< ", " >" },
				find = function()
					return surround_config.get_selection({ motion = "a>" })
				end,
				delete = "^(.)().-(.)()$",
			},
			["["] = {
				add = { "[", "]" },
				find = function()
					return surround_config.get_selection({ motion = "a[" })
				end,
				delete = "^(. ?)().-( ?.)()$",
			},
			["]"] = {
				add = { "[ ", " ]" },
				find = function()
					return surround_config.get_selection({ motion = "a]" })
				end,
				delete = "^(.)().-(.)()$",
			},
			invalid_key_behavior = {
				add = function(char)
					return { { char }, { char } }
				end,
				find = function(char)
					return surround_config.get_selection({
						pattern = vim.pesc(char) .. ".-" .. vim.pesc(char),
					})
				end,
				delete = function(char)
					return surround_config.get_selections({
						char = char,
						pattern = "^(.)().-(.)()$",
					})
				end,
				change = {
					target = function(char)
						return surround_config.get_selections({
							char = char,
							pattern = "^(.)().-(.)()$",
						})
					end,
				},
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
