local config = function()
	----------------------------------------------------------------------
	--                              guards                              --
	----------------------------------------------------------------------
	local fused_ok, _ = pcall(require, "fused")
	if not fused_ok then
		print("fused not installed")
		require("safdar.utils").notify("fused not installed for feline")
		return
	end

	local feline_ok, feline = pcall(require, "feline")

	if not feline_ok then
		print("feline not installed")
		require("safdar.utils").notify("feline not installed")
		return
	end

	----------------------------------------------------------------------
	--                              Colors                              --
	----------------------------------------------------------------------
	local fused_colors = require("fused.utils").colors
	local colors = {
		fg = fused_colors.base07,
		bg = fused_colors.base01,
		yellow = fused_colors.base09,
		pink = fused_colors.base12,
		sky = fused_colors.base10,
		teal = fused_colors.base13,
		green = fused_colors.base15,
		magenta = fused_colors.base14,
		blue = fused_colors.base17,
		red = fused_colors.base11,
		red_error = fused_colors.base08,
	}

	local icons = require("safdar.setup.ui.icons").status_line

	----------------------------------------------------------------------
	--                             modules                              --
	----------------------------------------------------------------------
	local lsp = require("feline.providers.lsp")
	local lsp_severity = vim.diagnostic.severity
	local git = require("feline.providers.git")

	----------------------------------------------------------------------
	--                              custom                              --
	----------------------------------------------------------------------
	local enable_only_in_full_buf = function()
		return vim.api.nvim_win_get_width(0) > 40
	end

	----------------------------------------------------------------------
	--                            components                            --
	----------------------------------------------------------------------
	-- Initialize the components table
	local components = {
		active = {},
		inactive = {},
	}

	-- Initialize left, mid and right
	table.insert(components.active, {})
	table.insert(components.active, {})
	table.insert(components.active, {})

	--=====================================================
	--                  left
	--=====================================================

	local mode_colors = {
		["n"] = { text = "NORMAL", color = colors.pink },
		["no"] = { text = "N-PENDING", color = colors.pink },
		["i"] = { text = "INSERT", color = colors.green },
		["ic"] = { text = "INSERT", color = colors.green },
		["t"] = { text = "TERMINAL", color = colors.green },
		["v"] = { text = "VISUAL", color = colors.blue },
		["V"] = { text = "V-LINE", color = colors.blue },
		[""] = { text = "V-BLOCK", color = colors.blue },
		["R"] = { text = "REPLACE", color = colors.red },
		["Rv"] = { text = "V-REPLACE", color = colors.red },
		["s"] = { text = "SELECT", color = colors.red },
		["S"] = { text = "S-LINE", color = colors.red },
		[""] = { text = "S-BLOCK", color = colors.red },
		["c"] = { text = "COMMAND", color = colors.magenta },
		["cv"] = { text = "COMMAND", color = colors.magenta },
		["ce"] = { text = "COMMAND", color = colors.magenta },
		["r"] = { text = "PROMPT", color = colors.sky },
		["rm"] = { text = "MORE", color = colors.sky },
		["r?"] = { text = "CONFIRM", color = colors.sky },
		["!"] = { text = "SHELL", color = colors.blue },
	}

	-- local sid_mode_hl = function()
	--     return {
	--         fg = mode_colors[vim.fn.mode()][2],
	--         bg = c.lightbg,
	--     }
	-- end

	-- components.active[1][1] = {
	--     provider = function()
	--         return " " .. mode_colors[vim.fn.mode()][1] .. " "
	--     end,
	--     hl = chad_mode_hl,
	-- }

	components.active[1][1] = {
		provider = "██",
		-- return '██ '
		-- enabled = enable_only_in_full_buf,
		hl = function()
			return {
				bg = colors.bg,
				fg = mode_colors[vim.fn.mode()].color,
			}
		end,
	}

	components.active[1][2] = {
		provider = function()
			local branch_name = git.git_branch()
			local branch = "  " -- little tux

			if package.loaded["gitsigns"] and branch_name ~= "" then
				branch = "  " .. branch_name
			end
			return branch
		end,
		enabled = enable_only_in_full_buf,
		hl = {
			fg = colors.fg,
			bg = colors.bg,
		},
		right_sep = {
			str = icons.triangle.equilateral.left,
			hl = {
				fg = colors.bg,
				bg = colors.fg,
			},
		},
	}

	components.active[1][3] = {
		provider = function()
			local orig_file_name = vim.fn.expand("%:p:t:r")
			local function split_long_string(orig_name_str, max_line_len)
				local length = #orig_name_str
				if length > max_line_len then
					return ""
				else
					return orig_name_str
				end
			end

			local filename = split_long_string(orig_file_name, 30) .. " "
			local extension = vim.fn.expand("%:e")
			local gIcon = require("nvim-web-devicons").get_icon(filename, extension)

			local provider
			if gIcon == nil then
				-- icon = "  " -- dont like this at the moment probably new icon

				-- Also include filename otherwise no filename when no icon
				provider = " " .. filename
			elseif tostring(filename) == "" then
				provider = " "
			else
				provider = " " .. gIcon .. " " .. filename .. " "
			end
			return provider
		end,
		enabled = enable_only_in_full_buf,
		hl = {
			fg = colors.bg,
			bg = colors.fg,
		},

		right_sep = {
			str = icons.triangle.equilateral.left,
			hl = {
				fg = colors.fg,
				bg = colors.bg,
			},
		},
	}

	components.active[1][4] = {
		provider = "git_diff_added",
		hl = { fg = colors.green, bg = colors.bg },
		icon = "  ",
	}
	-- diffModfified
	components.active[1][5] = {
		provider = "git_diff_changed",
		hl = { fg = colors.sky, bg = colors.bg },
		icon = " ⦿ ",
	}
	-- diffRemove
	components.active[1][6] = {
		provider = "git_diff_removed",
		hl = { fg = colors.red, bg = colors.bg },
		icon = "  ",
	}

	--=====================================================
	--                  center
	--=====================================================

	local function show_lsp_progress()
		local Lsp = vim.lsp.util.get_progress_messages()[1]
		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = {
				-- ◐ ◓ ◑ ◒
				"◐",
				"◓",
				"◑",
				"◒",
				"◐",
				"◓",
				"◑",
				"◒",
				"◐",
				"◓",
				"◑",
				"◒",

				-- "⠋",
				-- "⠇",
				-- "⠦",
				-- "⠙",
				-- "⠹",
				-- "⠼",
				-- "⠴",
				-- "⠸",
				-- "⠦",
				-- "⠧",
				-- "⠇",
				-- "⠏",
			}

			local success_icon = {
				-- "",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
				"",
			}

			local ms = vim.loop.hrtime() / 1000000
			local frame = math.floor(ms / 120) % #spinners

			if percentage >= 70 then
				return string.format(
					" %%<%s %s %s (%s%%%%) ",
					success_icon[frame + 1],
					title,
					msg,
					percentage
				)
			else
				return string.format(
					" %%<%s %s %s (%s%%%%) ",
					spinners[frame + 1],
					title,
					msg,
					percentage
				)
			end
		end

		local cur_buf_clients = vim.lsp.buf_get_clients()
		local clients_str = ""
		for _, server in pairs(cur_buf_clients) do
			clients_str = clients_str .. server.name .. ","
		end

		local client_list = string.sub(clients_str, 1, -2)
		return "[" .. client_list .. "]"
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("setting_feline_lsp_buf_clients", { clear = true }),
		callback = function()
			components.active[2][1] = {
				provider = function()
					return show_lsp_progress()
				end,
				enabled = enable_only_in_full_buf,
				hl = { fg = colors.sky, bg = colors.bg },
			}
		end,
	})

	--=====================================================
	--                  right
	--=====================================================
	components.active[3][1] = {
		provider = icons.triangle.acute.right,
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
				or lsp.diagnostics_exist(lsp_severity.WARN)
				or lsp.diagnostics_exist(lsp_severity.HINT)
				or lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = colors.bg,
			bg = colors.bg,
		},
	}

	components.active[3][2] = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = { fg = colors.red_error, bg = colors.bg },
		icon = "  ",
	}

	components.active[3][3] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = { fg = colors.yellow, bg = colors.bg },
		icon = "  ",
	}

	components.active[3][4] = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = { fg = colors.sky, bg = colors.bg },
		icon = "  ",
	}

	components.active[3][5] = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = { fg = colors.teal, bg = colors.bg },
		icon = "  ",
	}

	components.active[3][6] = {
		provider = " ",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
				or lsp.diagnostics_exist(lsp_severity.WARN)
				or lsp.diagnostics_exist(lsp_severity.HINT)
				or lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = colors.bg,
			bg = colors.bg,
		},
	}

	components.active[3][7] = {
		provider = icons.triangle.equilateral.right,
		enabled = enable_only_in_full_buf,
		hl = {
			fg = colors.fg,
			bg = colors.bg,
		},
	}

	components.active[3][7] = {
		provider = function()
			local lsp_symbol_str = "   LSP "
			-- local lsp_symbol_str_not_atcive = "   no LSP "
			local lsp_symbol_str_not_atcive = " "

			if next(vim.lsp.buf_get_clients()) ~= nil then
				local lsp_status_slant = lsp_symbol_str .. icons.triangle.equilateral.right
				return lsp_status_slant
			else
				local lsp_status_slant = lsp_symbol_str_not_atcive
					.. "" -- just to keep up with style
					.. icons.triangle.equilateral.right
				return lsp_status_slant
			end
		end,
		enabled = enable_only_in_full_buf,
		hl = { fg = colors.bg, bg = colors.fg },
		left_sep = {
			str = icons.triangle.equilateral.right,
			hl = {
				fg = colors.fg,
				bg = colors.bg,
			},
		},
	}

	components.active[3][8] = {
		provider = function()
			local current_line = vim.fn.line(".")
			local total_line = vim.fn.line("$")

			if current_line == 1 then
				return " Top "
			elseif current_line == vim.fn.line("$") then
				return " Bot "
			end
			local result, _ = math.modf((current_line / total_line) * 100)
			return " " .. result .. "%% "
		end,

		enabled = enable_only_in_full_buf,

		hl = {
			fg = colors.fg,
			bg = colors.bg,
		},
	}

	components.active[3][9] = {
		provider = "scroll_bar",
		enabled = enable_only_in_full_buf,
		hl = {
			fg = colors.blue,
			bg = colors.bg,
			style = "bold",
		},
	}

	feline.setup({
		colors = {
			bg = colors.base02,
			fg = colors.base07,
		},
		components = components,
		force_inactive = {
			filetypes = {
				"^NvimTree$",
				"^Outline$",
				"DiffviewFileHistory",
				"DiffviewFiles",
			},
			buftypes = {
				"^terminal$",
				"prompt",
			},
			bufnames = {
				"neorg://norg/Projects.norg",
				"neorg://norg/Neorg Toc.norg",
			},
		},
	})
end

return { config = config }
