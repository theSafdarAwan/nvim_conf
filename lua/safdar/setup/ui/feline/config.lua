---@diagnostic disable: unused-local
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
		white = fused_colors.base07,
		grey_white = fused_colors.base06,
		dark1 = fused_colors.base01,
		dark2 = fused_colors.base02,
		dark3 = fused_colors.base03,
		dark4 = fused_colors.base04,
		dark5 = fused_colors.base05,
		yellow = fused_colors.base09,
		pink = fused_colors.base12,
		cyan = fused_colors.base10,
		teal = fused_colors.base13,
		green = fused_colors.base15,
		magenta = fused_colors.base14,
		blue = fused_colors.base17,
		red = fused_colors.base11,
		red_error = fused_colors.base08,
	}

	local icons = require("safdar.setup.ui.icons")

	----------------------------------------------------------------------
	--                             modules                              --
	----------------------------------------------------------------------
	local lsp = require("feline.providers.lsp")
	local lsp_severity = vim.diagnostic.severity
	local git = require("feline.providers.git")

	----------------------------------------------------------------------
	--                           custom funcs                           --
	----------------------------------------------------------------------
	local enable_in_full_win = function()
		return vim.api.nvim_win_get_width(0) > 40
	end

	----------------------------------------------------------------------
	--                               mode                               --
	----------------------------------------------------------------------
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
		["r"] = { text = "PROMPT", color = colors.cyan },
		["rm"] = { text = "MORE", color = colors.cyan },
		["r?"] = { text = "CONFIRM", color = colors.cyan },
		["!"] = { text = "SHELL", color = colors.blue },
	}

	local mode = {
		provider = function(self)
			local icon = icons.status_line.misc.mode_icon
			local cur_mode = vim.fn.mode()
			if cur_mode == "R" then
				icon = icons.kind.TabNine
			elseif cur_mode == "i" then
				icon = icons.git.FileModifiedRound
			elseif cur_mode == "v" or cur_mode == "V" or cur_mode == "" then
				icon = icons.kind.Null
			end

			local mode_info = mode_colors[cur_mode]
			self.hl.bg = mode_info.color
			return " " .. icon .. " "
		end,
		hl = {
			fg = colors.dark1,
		},
	}

	----------------------------------------------------------------------
	--                            git branch                            --
	----------------------------------------------------------------------
	local git_branch = {
		provider = function(self)
			local git_is_ok = function()
				local branch = git.git_branch()
				if package.loaded["gitsigns"] and branch ~= "" then
					return true
				end
			end
			local git_branch_icon = icons.misc.Tux
			local branch_name = ""
			if git_is_ok() then
				git_branch_icon = icons.git.Branch
				branch_name = git.git_branch()
			end
			self.left_sep.str = " " .. git_branch_icon .. " "
			if not string.find(vim.fn.expand("%:t"), "[%d?%a]") then
				self.right_sep.str = ""
			else
				self.right_sep.str = icons.status_line.round.right
			end
			return branch_name .. " "
		end,
		hl = {
			fg = colors.white,
			bg = colors.dark3,
		},
		left_sep = {
			str = "",
			hl = {
				fg = colors.yellow,
				bg = colors.dark3,
			},
		},
		right_sep = {
			str = "",
			hl = {
				fg = colors.dark1,
				bg = colors.dark3,
			},
		},
		enabled = enable_in_full_win,
	}

	----------------------------------------------------------------------
	--                            file name                             --
	----------------------------------------------------------------------
	local file_name = {
		provider = function(self)
			-- file name with no extension
			local just_file_name = vim.fn.expand("%:p:t:r")
			--- dictates the decision to display or not display file name based
			--- on <args>.
			---@param max_line_len number maximum file name length.
			---@return string either empty string if `max_line_len` is exceeded
			--- else `just_file_name`
			local function file_name_lenght(max_line_len)
				local length = #just_file_name
				if length > max_line_len then
					return ""
				else
					return just_file_name
				end
			end
			local truncated_file_name = file_name_lenght(30)
			local provider = " "
			if #truncated_file_name > 1 then
				provider = truncated_file_name
			end

			if string.find(just_file_name, "[%d?%a]") then
				local file_name_with_ext = vim.fn.expand("%:t")
				local file_ext = vim.fn.expand("%:e")
				local ft_icon = require("nvim-web-devicons").get_icon(file_name_with_ext, file_ext)
				local _, fg = require("nvim-web-devicons").get_icon_color(file_name_with_ext, file_ext)
				if not ft_icon then
					return icons.kind.Null
				end
				self.left_sep.str = ft_icon
				self.left_sep.hl.fg = fg
			else
				self.left_sep.str = nil
				self.left_sep.hl.fg = nil
			end
			if not string.find(provider, "[%a?%d]") then
				return ""
			end
			return " " .. provider .. " "
		end,
		enabled = enable_in_full_win,
		hl = {
			fg = colors.white,
			bg = colors.dark1,
		},
		left_sep = {
			str = "",
			hl = { fg = "", bg = colors.dark1 },
		},
		right_sep = {
			str = icons.status_line.round.left,
			hl = {
				fg = colors.dark1,
				bg = colors.dark3,
			},
		},
	}

	----------------------------------------------------------------------
	--                               Git                                --
	----------------------------------------------------------------------
	local git_add = {
		provider = "git_diff_added",
		hl = { fg = colors.green, bg = colors.dark1 },
		icon = " " .. icons.git.FileAddedRound .. " ",
	}
	-- diffModfified
	local git_changed = {
		provider = "git_diff_changed",
		hl = { fg = colors.cyan, bg = colors.dark1 },
		icon = " " .. icons.git.FileModifiedRound .. " ",
	}
	-- diffRemove
	local git_remove = {
		provider = "git_diff_removed",
		hl = { fg = colors.red, bg = colors.dark1 },
		icon = " " .. icons.git.FileRemoveRound .. " ",
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

	local lsp_info
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("setting_feline_lsp_buf_clients", { clear = true }),
		callback = function()
			lsp_info = {
				provider = function()
					return show_lsp_progress()
				end,
				enabled = enable_in_full_win,
				hl = { fg = colors.cyan, bg = colors.dark1 },
			}
		end,
	})

	--=====================================================
	--                  right
	--=====================================================
	local diagnostics_dummy1 = {
		provider = icons.status_line.triangle.acute.right,
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
				or lsp.diagnostics_exist(lsp_severity.WARN)
				or lsp.diagnostics_exist(lsp_severity.HINT)
				or lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = colors.dark1,
			bg = colors.dark1,
		},
	}

	local diagnostics_error = {
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
		end,
		hl = { fg = colors.red_error, bg = colors.dark1 },
		icon = "  ",
	}

	local diagnostics_warning = {
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.WARN)
		end,
		hl = { fg = colors.yellow, bg = colors.dark1 },
		icon = "  ",
	}

	local diagnostics_hint = {
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.HINT)
		end,
		hl = { fg = colors.cyan, bg = colors.dark1 },
		icon = "  ",
	}

	local diagnostics_info = {
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = { fg = colors.teal, bg = colors.dark1 },
		icon = "  ",
	}

	local diagnostics_dummy2 = {
		provider = " ",
		enabled = function()
			return lsp.diagnostics_exist(lsp_severity.ERROR)
				or lsp.diagnostics_exist(lsp_severity.WARN)
				or lsp.diagnostics_exist(lsp_severity.HINT)
				or lsp.diagnostics_exist(lsp_severity.INFO)
		end,
		hl = {
			fg = colors.dark1,
			bg = colors.dark1,
		},
	}

	local lsp_active_icon = {
		provider = function()
			local lsp_symbol_str = "   LSP "
			-- local lsp_symbol_str_not_atcive = "   no LSP "
			local lsp_symbol_str_not_atcive = " "

			if next(vim.lsp.buf_get_clients()) ~= nil then
				local lsp_status_slant = lsp_symbol_str .. icons.status_line.triangle.equilateral.right
				return lsp_status_slant
			else
				local lsp_status_slant = lsp_symbol_str_not_atcive
					.. "" -- just to keep up with style
					.. icons.status_line.triangle.equilateral.right
				return lsp_status_slant
			end
		end,
		enabled = enable_in_full_win,
		hl = { fg = colors.dark1, bg = colors.white },
		left_sep = {
			str = icons.status_line.triangle.equilateral.right,
			hl = {
				fg = colors.white,
				bg = colors.dark1,
			},
		},
	}

	local location = {
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

		enabled = enable_in_full_win,

		hl = {
			fg = colors.white,
			bg = colors.dark1,
		},
	}

	local location_bar = {
		provider = "scroll_bar",
		enabled = enable_in_full_win,
		hl = {
			fg = colors.blue,
			bg = colors.dark1,
			style = "bold",
		},
	}

	----------------------------------------------------------------------
	-- Initialize the components table
	local components = {
		active = {
			{
				mode,
				git_branch,
				file_name,
				git_add,
				git_changed,
				git_remove,
			},
			{
				lsp_info,
			},
			{
				diagnostics_dummy1,
				diagnostics_error,
				diagnostics_warning,
				diagnostics_hint,
				diagnostics_info,
				diagnostics_dummy2,
				lsp_active_icon,
				location,
				location_bar,
			},
		},
		inactive = {},
	}

	feline.setup({
		colors = {
			fg = colors.white,
			bg = colors.dark4,
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
