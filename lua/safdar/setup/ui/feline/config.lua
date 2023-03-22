local config = function()
	local fused_ok, _ = pcall(require, "fused")
	if not fused_ok then
		print("fused not found")
		require("safdar.utils").notify("fused not found for feline")
		return
	end

	local feline_ok, feline = pcall(require, "feline")

	if not feline_ok then
		print("feline not found")
		require("safdar.utils").notify("feline not found")
		return
	end

	local cp = require("fused.utils").colors
	local c = {
		white = cp.base07,
		dark = cp.base01,
		warn = cp.base09,
		err = cp.base11,
		err_sev = cp.base08,
		info = cp.base10,
		hint = cp.base10,
		magenta = cp.base14,
		green = cp.base15,
		blue = cp.base16,
		cyan = cp.base13,
	}

	local lsp = require("feline.providers.lsp")
	local lsp_severity = vim.diagnostic.severity

	local git = require("feline.providers.git")

	local icon_styles = {
		default = {
			left = "",
			right = " ",
			main_icon = "  ",
			vi_mode_icon = " ",
			position_icon = " ",
		},
		default2 = {
			left = "",
			right = "",
			main_icon = "  ",
			vi_mode_icon = " ",
			position_icon = " ",
		},

		block = {
			left = " ",
			right = " ",
			main_icon = "   ",
			vi_mode_icon = "  ",
			position_icon = "  ",
		},

		round = {
			left = "",
			right = "",
			main_icon = "  ",
			vi_mode_icon = " ",
			position_icon = " ",
		},

		slant = {
			left = "",
			right = " ",
			main_icon = "  ",
			vi_mode_icon = " ",
			position_icon = " ",
		},
	}

	--=====================================================
	--               defining custom functions
	--=====================================================
	local enable_only_in_full_buf = function()
		return vim.api.nvim_win_get_width(0) > 40
	end

	--=====================================================
	--                  defining compnents
	--=====================================================

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
		["n"] = { "NORMAL", c.warn },
		["no"] = { "N-PENDING", c.warn },
		["i"] = { "INSERT", c.green },
		["ic"] = { "INSERT", c.green },
		["t"] = { "TERMINAL", c.green },
		["v"] = { "VISUAL", c.blue },
		["V"] = { "V-LINE", c.blue },
		[""] = { "V-BLOCK", c.blue },
		["R"] = { "REPLACE", c.err },
		["Rv"] = { "V-REPLACE", c.err },
		["s"] = { "SELECT", c.err },
		["S"] = { "S-LINE", c.err },
		[""] = { "S-BLOCK", c.err },
		["c"] = { "COMMAND", c.magenta },
		["cv"] = { "COMMAND", c.magenta },
		["ce"] = { "COMMAND", c.magenta },
		["r"] = { "PROMPT", c.info },
		["rm"] = { "MORE", c.info },
		["r?"] = { "CONFIRM", c.info },
		["!"] = { "SHELL", c.blue },
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
				fg = mode_colors[vim.fn.mode()][2],
				bg = mode_colors[vim.fn.mode()][2],
			}
		end,
	}

	components.active[1][2] = {
		provider = function()
			local branch_name = git.git_branch()
			local branch = "  " -- little tux

			vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
			if vim.v.shell_error == 0 and branch_name ~= "" then
				branch = "  " .. branch_name
			end
			return branch
		end,
		enabled = enable_only_in_full_buf,
		hl = {
			fg = c.white,
			bg = c.dark,
		},
		right_sep = {
			str = icon_styles.default2.right,
			hl = {
				fg = c.dark,
				bg = c.white,
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
			fg = c.dark,
			bg = c.white,
		},

		right_sep = {
			str = icon_styles.default2.right,
			hl = {
				fg = c.white,
				bg = c.dark,
			},
		},
	}

	components.active[1][4] = {
		provider = "git_diff_added",
		hl = { fg = c.green, bg = c.dark },
		icon = "  ",
	}
	-- diffModfified
	components.active[1][5] = {
		provider = "git_diff_changed",
		hl = { fg = c.cyan, bg = c.dark },
		icon = " ⦿ ",
	}
	-- diffRemove
	components.active[1][6] = {
		provider = "git_diff_removed",
		hl = { fg = c.err, bg = c.dark },
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
				hl = { fg = c.cyan, bg = c.dark },
			}
		end,
	})

	--=====================================================
	--                  right
	--=====================================================
	components.active[3][1] = {
		provider = icon_styles.slant.left,
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
				or lsp.diagnostics_exist(lsp_severity.WARN)
				or lsp.diagnostics_exist(lsp_severity.HINT)
				or lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = c.dark,
			bg = c.dark,
		},
	}

	components.active[3][2] = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = { fg = c.err_sev, bg = c.dark },
		icon = "  ",
	}

	components.active[3][3] = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = { fg = c.warn, bg = c.dark },
		icon = "  ",
	}

	components.active[3][4] = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = { fg = c.hint, bg = c.dark },
		icon = "  ",
	}

	components.active[3][5] = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = { fg = c.info, bg = c.dark },
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
			fg = c.dark,
			bg = c.dark,
		},
	}

	components.active[3][7] = {
		provider = icon_styles.default.left,
		enabled = enable_only_in_full_buf,
		hl = {
			fg = c.white,
			bg = c.dark,
		},
	}

	components.active[3][7] = {
		provider = function()
			local lsp_symbol_str = "   LSP "
			-- local lsp_symbol_str_not_atcive = "   no LSP "
			local lsp_symbol_str_not_atcive = " "

			if next(vim.lsp.buf_get_clients()) ~= nil then
				local lsp_status_slant = lsp_symbol_str .. icon_styles.default.left
				return lsp_status_slant
			else
				local lsp_status_slant = lsp_symbol_str_not_atcive
					.. "" -- just to keep up with style
					.. icon_styles.default.left
				return lsp_status_slant
			end
		end,
		enabled = enable_only_in_full_buf,
		hl = { fg = c.dark, bg = c.white },
		left_sep = {
			str = icon_styles.default.left,
			hl = {
				fg = c.white,
				bg = c.dark,
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
			fg = c.white,
			bg = c.dark,
		},
	}

	components.active[3][9] = {
		provider = "scroll_bar",
		enabled = enable_only_in_full_buf,
		hl = {
			fg = c.blue,
			bg = c.dark,
			style = "bold",
		},
	}

	feline.setup({
		colors = {
			bg = c.base02,
			fg = c.base07,
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

-- TODO: add autocmd to realod
-- local autocmd = vim.api.nvim_create_autocmd("Feline")

return { config = config }
