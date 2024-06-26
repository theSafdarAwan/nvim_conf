local config = function()
	----------------------------------------------------------------------
	--                              guards                              --
	----------------------------------------------------------------------
	local fused_ok, _ = pcall(require, "fused")
	if not fused_ok then
		print("fused.nvim not installed")
		require("safdar.utils").notify("fused.nvim not installed for feline")
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
		white = fused_colors.base05,
		grey_white = fused_colors.base04,
		dark1 = fused_colors.bg,
		dark2 = fused_colors.popup_bg,
		yellow = fused_colors.base07,
		pink = fused_colors.base10,
		cyan = fused_colors.base08,
		teal = fused_colors.base01,
		green = fused_colors.base13,
		magenta = fused_colors.base12,
		blue = fused_colors.base15,
		red = fused_colors.base09,
		red_error = fused_colors.base06,
	}

	local icons = require("safdar.setup.ui.icons")

	----------------------------------------------------------------------
	--                             modules                              --
	----------------------------------------------------------------------
	local lsp_provider = require("feline.providers.lsp")
	local git_provider = require("feline.providers.git")

	----------------------------------------------------------------------
	--                           custom funcs                           --
	----------------------------------------------------------------------
	local enable_in_full_win = function()
		return vim.api.nvim_win_get_width(0) > 40
	end

	local function enable_diagnostics(diagnostic_str)
		if lsp_provider.diagnostics_exist(vim.diagnostic.severity[diagnostic_str]) then
			return true
		end
	end

	local noice_is_active = function()
	--	if not require("noice").api.statusline.mode.get() then
	--		return true
	--	end
	end

	----------------------------------------------------------------------
	--                            separator                             --
	----------------------------------------------------------------------
	local separator = {
		left_sep = { str = " ", hl = { fg = colors.dark1, bg = colors.dark2 } },
		right_sep = { str = " ", hl = { fg = colors.dark1, bg = colors.dark2 } },
		hl = { fg = colors.dark1, bg = colors.dark2 },
	}

	----------------------------------------------------------------------
	--                               mode                               --
	----------------------------------------------------------------------
	local mode_colors = {
		["n"] = { text = "NORMAL", color = colors.blue },
		["no"] = { text = "N-PENDING", color = colors.blue },
		["i"] = { text = "INSERT", color = colors.green },
		["ic"] = { text = "INSERT", color = colors.green },
		["t"] = { text = "TERMINAL", color = colors.green },
		["v"] = { text = "VISUAL", color = colors.pink },
		["V"] = { text = "V-LINE", color = colors.pink },
		[""] = { text = "V-BLOCK", color = colors.pink },
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
		["!"] = { text = "SHELL", color = colors.pink },
	}

	local mode = {
		provider = function()
			local icon = icons.misc.ModifiedCircle
			local cur_mode = vim.fn.mode()
			if cur_mode == "R" then
				icon = icons.ui.Fire
			elseif cur_mode == "i" then
				icon = icons.misc.Pen
			elseif cur_mode == "v" or cur_mode == "V" or cur_mode == "" then
				icon = icons.misc.Cod
			end
			return " " .. icon .. " "
		end,
		hl = function()
			local color = mode_colors[vim.fn.mode()].color
			return {
				fg = colors.dark1,
				bg = color,
			}
		end,
	}

	----------------------------------------------------------------------
	--                               Git                                --
	----------------------------------------------------------------------
	local git = {
		branch = {
			provider = function(self)
				local git_is_ok = function()
					local branch = git_provider.git_branch()
					if package.loaded["gitsigns"] and branch ~= "" then
						return true
					end
				end
				local git_branch_icon = ""
				local branch_name = ""
				if git_is_ok() then
					git_branch_icon = icons.git.Branch
					branch_name = git_provider.git_branch() .. " "
				end
				self.left_sep.str = " " .. git_branch_icon .. " "
				self.left_sep.hl.bg = colors.dark2
				if not string.find(vim.fn.expand("%:t"), "[%d?%a]") then
					self.left_sep.hl.bg = colors.dark1
				end
				return branch_name
			end,
			hl = {
				fg = colors.white,
				bg = colors.dark2,
			},
			left_sep = {
				str = "",
				hl = {
					fg = colors.yellow,
					bg = "",
				},
			},
			enabled = enable_in_full_win,
		},
		diff_removed = {
			provider = "git_diff_removed",
			hl = { fg = colors.red, bg = colors.dark2 },
			icon = " " .. icons.git.FileRemoveRound .. " ",
		},
		diff_added = {
			provider = "git_diff_added",
			hl = { fg = colors.green, bg = colors.dark2 },
			icon = " " .. icons.git.FileAddedRound .. " ",
		},
		diff_changed = {
			provider = "git_diff_changed",
			hl = { fg = colors.cyan, bg = colors.dark2 },
			icon = function()
				local str = icons.git.FileModifiedRound .. " "
				local diff_removed, _ = git_provider.git_diff_removed()
				diff_removed = string.find(diff_removed, "[%d]")
				local diff_added, _ = git_provider.git_diff_added()
				diff_added = string.find(diff_added, "[%d]")
				if not diff_added and not diff_removed then
					str = " " .. str
				end
				return str
			end,
		},
	}
	local git_sep = {
		diff_added = vim.tbl_deep_extend("force", {
			provider = function(self)
				local diff_removed, _ = git_provider.git_diff_removed()
				diff_removed = string.find(diff_removed, "[%d]")
				local diff_added, _ = git_provider.git_diff_added()
				diff_added = string.find(diff_added, "[%d]")
				self.right_sep = nil
				if diff_removed and diff_added then
					return icons.misc.ColumnBarThin
				end
				return ""
			end,
		}, separator),
		diff_changed = vim.tbl_deep_extend("force", {
			provider = function(self)
				local diff_removed, _ = git_provider.git_diff_removed()
				diff_removed = string.find(diff_removed, "[%d]")
				local diff_added, _ = git_provider.git_diff_added()
				diff_added = string.find(diff_added, "[%d]")
				local diff_changed, _ = git_provider.git_diff_changed()
				diff_changed = string.find(diff_changed, "[%d]")
				self.right_sep = nil
				if diff_changed then
					if diff_removed or diff_added then
						return icons.misc.ColumnBarThin
					end
				end
				return ""
			end,
		}, separator),
	}

	----------------------------------------------------------------------
	--                               file                               --
	----------------------------------------------------------------------
	local filename = {
		provider = function(self)
			-- file name with no extension
			local file_name_no_ext = vim.fn.expand("%:p:t:r")
			--- dictates the decision to display or not display file name based
			--- on <args>.
			---@param max_line_len number maximum file name length.
			---@return string either empty string if `max_line_len` is exceeded
			--- else `just_file_name`
			local function file_name_lenght(max_line_len)
				local length = #file_name_no_ext
				if length > max_line_len then
					return ""
				else
					return file_name_no_ext
				end
			end
			-- get the file name for provider
			local provider_content = file_name_lenght(30)
			provider_content = " " .. provider_content .. " "

			if string.find(file_name_no_ext, "[%d?%a]") then
				local file_name_with_ext = vim.fn.expand("%:t")
				local file_ext = vim.fn.expand("%:e")
				local ft_icon = require("nvim-web-devicons").get_icon(file_name_with_ext, file_ext)
				local _, fg = require("nvim-web-devicons").get_icon_color(file_name_with_ext, file_ext)
				if not ft_icon then
					ft_icon = icons.kind.Event
				end
				self.left_sep.str = " " .. ft_icon
				self.left_sep.hl.fg = fg or colors.red
				self.hl.fg = self.left_sep.hl.fg
			end
			if not string.find(file_name_no_ext, "[%a?%d]") then
				return ""
			end
			return provider_content
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
			str = "",
			hl = {
				fg = colors.dark1,
				bg = colors.dark2,
			},
		},
	}
	local filename_sep = vim.tbl_deep_extend("force", {
		provider = function(self)
			local file_name_valid = string.find(filename.provider(filename), "[%a%d]")
			local git_branch_valid = string.find(git.branch.provider(git.branch), "[%a%d]")
			self.left_sep = nil
			self.right_sep = nil
			if file_name_valid and git_branch_valid then
				return icons.misc.ColumnBarThin
			end
			return ""
		end,
	}, separator)
	local file_modification_status = {
		provider = function()
			if vim.bo.modified then
				return icons.misc.Robot .. " file not saved."
			else
				return " "
			end
		end,
		enabled = function ()
			-- return noice_is_active()
		end,
		hl = { style = "bold", fg = colors.blue, bg = colors.dark2 },
	}

	----------------------------------------------------------------------
	--                               Lsp                                --
	----------------------------------------------------------------------
	local lsp = {
		clients = {
			provider = function()
				local cur_buf_clients = vim.lsp.get_clients()
				local clients_str = ""
				for _, server in pairs(cur_buf_clients) do
					for _, ft in ipairs(server.config.filetypes) do
						if ft == vim.bo.filetype then
							clients_str = clients_str .. server.name .. ","
						end
					end
				end
				local client_list = string.sub(clients_str, 1, -2)
				if #client_list > 1 then
					client_list = icons.ui.Setting .. " " .. client_list
				else
					client_list = ""
				end
				return client_list
			end,
			enabled = function()
				-- local Lsp = vim.lsp.util.get_progress_messages()[1]
				-- local Lsp_progress = false
				-- if Lsp then
				-- 	Lsp_progress = true
				-- end
				-- return not noice_is_active() and not lsp_progress
				return noice_is_active() and not vim.bo.modified
			end,
			hl = { fg = colors.blue, bg = colors.dark2 },
		},
		progress = {
			provider = function()
				--- NOTE> this util function is only helpful here
				---@param tbl table to be merged with.
				---@param num number for how many times the `tbl` should be merged
				---@return table duplicated table
				local function duplicate_tbl(tbl, num)
					local t = {}
					local quantity = 1
					while true do
						if quantity > num then
							break
						end
						for _, v in ipairs(tbl) do
							table.insert(t, v)
						end
						quantity = quantity + 1
					end
					return t
				end
				local Lsp = vim.lsp.util.get_progress_messages()[1]
				if Lsp then
					local msg = Lsp.message or ""
					local percentage = Lsp.percentage or 0
					local title = Lsp.title or ""
					local spinners = duplicate_tbl(icons.animation.circle, 4)
					local success_icon = duplicate_tbl({ icons.animation.Done }, 12)
					local ms = vim.loop.hrtime() / 1000000
					local frame = math.floor(ms / 120) % #spinners
					if percentage >= 90 then
						return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
					else
						return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
					end
				else
					return ""
				end
			end,
			enabled = function()
				return noice_is_active()
			end,
			hl = { fg = colors.pink, bg = colors.dark2, style = "italic" },
		},
	}

	----------------------------------------------------------------------
	--                         Lsp Diagnostics                          --
	----------------------------------------------------------------------
	local diagnostics = {
		ERROR = {
			provider = "diagnostic_errors",
			enabled = function()
				return enable_diagnostics("ERROR")
			end,
			hl = { fg = colors.red_error, bg = colors.dark2 },
			icon = icons.diagnostics.BoldError .. " ",
			right_sep = { str = " ", hl = { fg = colors.dark2, bg = colors.dark2 } },
		},
		WARN = {
			provider = "diagnostic_warnings",
			enabled = function()
				return enable_diagnostics("WARN")
			end,
			hl = { fg = colors.yellow, bg = colors.dark2 },
			icon = icons.diagnostics.BoldWarning .. " ",
			right_sep = {
				str = function()
					if not enable_diagnostics("ERROR") then
						return " "
					else
						return ""
					end
				end,
				hl = { fg = colors.dark2, bg = colors.dark2 },
			},
		},
		HINT = {
			provider = "diagnostic_hints",
			enabled = function()
				return enable_diagnostics("HINT")
			end,
			hl = { fg = colors.cyan, bg = colors.dark2 },
			icon = icons.diagnostics.BoldHint .. " ",
			right_sep = {
				str = function()
					if not enable_diagnostics("ERROR") and not enable_diagnostics("WARN") then
						return " "
					else
						return ""
					end
				end,
				hl = { fg = colors.dark2, bg = colors.dark2 },
			},
		},
		INFO = {
			provider = "diagnostic_info",
			enabled = function()
				return enable_diagnostics("INFO")
			end,
			hl = { fg = colors.teal, bg = colors.dark2 },
			icon = icons.diagnostics.BoldInformation .. " ",
			right_sep = {
				str = function()
					if
						not enable_diagnostics("ERROR")
						and not enable_diagnostics("WARN")
						and not enable_diagnostics("HINT")
					then
						return " "
					else
						return ""
					end
				end,
				hl = { fg = colors.dark2, bg = colors.dark2 },
			},
		},
	}
	local diagnostics_sep = {
		WARN = vim.tbl_deep_extend("force", {
			provider = function(self)
				self.rigth_sep = nil
				if enable_diagnostics("ERROR") and enable_diagnostics("WARN") then
					return icons.misc.ColumnBarThin
				end
				return ""
			end,
		}, separator),
		HINT = vim.tbl_deep_extend("force", {
			provider = function(self)
				self.rigth_sep = nil
				if enable_diagnostics("HINT") then
					if enable_diagnostics("ERROR") or enable_diagnostics("WARN") then
						return icons.misc.ColumnBarThin
					end
				end
				return ""
			end,
		}, separator),
		INFO = vim.tbl_deep_extend("force", {
			provider = function(self)
				self.rigth_sep = nil
				if enable_diagnostics("INFO") then
					if enable_diagnostics("ERROR") or enable_diagnostics("WARN") or enable_diagnostics("HINT") then
						return icons.misc.ColumnBarThin
					end
				end
				return ""
			end,
		}, separator),
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
			if result < 10 then
				---@diagnostic disable-next-line: cast-local-type
				result = "0" .. tostring(result)
			end
			return " " .. result .. "%% "
		end,
		left_sep = {
			str = function()
				local str = icons.misc.Position
				if not vim.bo.modifiable or vim.bo.readonly then
					str = icons.misc.Shield
				end
				return " " .. str .. " "
			end,
			hl = function()
				--- mode colors
				local color = mode_colors[vim.fn.mode()].color
				return {
					fg = colors.dark1,
					bg = color,
				}
			end,
		},
		hl = function()
			--- mode colors
			local color = mode_colors[vim.fn.mode()].color
			return {
				fg = color,
				bg = colors.dark1,
			}
		end,
	}
	----------------------------------------------------------------------
	--                              Noice                               --
	----------------------------------------------------------------------
	local noice_macro_recording = {
		provider = function()
		--	if require("noice").api.statusline.mode.get() then
		--		return icons.misc.Watch .. " " .. require("noice").api.statusline.mode.get()
		--	end
			return " "
		end,
		hl = { style = "bold", fg = colors.pink, bg = colors.dark2 },
	}

	local components = {
		active = {
			{
				mode,
				git.branch,
				filename_sep,
				filename,
				git.diff_removed,
				git_sep.diff_added,
				git.diff_added,
				git_sep.diff_changed,
				git.diff_changed,
			},
			{
				-- lsp_progress,
				lsp.clients,
				noice_macro_recording,
				file_modification_status,
			},
			{
				diagnostics.INFO,
				diagnostics_sep.INFO,
				diagnostics.HINT,
				diagnostics_sep.HINT,
				diagnostics.WARN,
				diagnostics_sep.WARN,
				diagnostics.ERROR,
				location,
			},
		},
		inactive = {},
	}

	feline.setup({
		colors = {
			fg = colors.white,
			bg = colors.dark2,
		},
		components = components,
		force_inactive = {
			filetypes = {
				-- "^NvimTree$",
				-- "^Outline$",
				-- "DiffviewFileHistory",
				-- "DiffviewFiles",
				-- "Trouble",
				-- "alpha",
				-- "startuptime",
				-- "notify"
			},
			buftypes = {
				"^terminal$",
				"prompt",
				"nofile",
			},
			bufnames = {
				"neorg://norg/Projects.norg",
				"neorg://norg/Neorg Toc.norg",
			},
		},
	})
end

return { config = config }
