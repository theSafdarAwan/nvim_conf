--  FOR PEOPEL READING THIS
--  this config include some things or to be precise styles those
--  aren't visible at the time because i change the theme so i change the colors of
--  some components to the bg color

--=====================================================
--                  general
--=====================================================
local vim = vim
local enable_only_in_full_buf
local colors = require("safdar.plugins.personal.fused-nvim.pallete")
local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity

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
-- local enable_only_in_full_buf = function(winid)
-- 	return vim.api.nvim_win_get_width(winid) > 50
-- end

-- function()
--     if vim.lsp.buf_get_clients() == true then
--         return true
--     elseif vim.lsp.buf_get_clients() == nil then
--         return nil
--     end
-- end

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
	["n"] = { "NORMAL", colors.fl_color_4 },
	["no"] = { "N-PENDING", colors.fl_color_4 },
	["i"] = { "INSERT", colors.fl_color_1 },
	["ic"] = { "INSERT", colors.fl_color_1 },
	["t"] = { "TERMINAL", colors.fl_color_7 },
	["v"] = { "VISUAL", colors.fl_color_2 },
	["V"] = { "V-LINE", colors.fl_color_2 },
	[""] = { "V-BLOCK", colors.fl_color_2 },
	["R"] = { "REPLACE", colors.fl_color_13 },
	["Rv"] = { "V-REPLACE", colors.fl_color_13 },
	["s"] = { "SELECT", colors.fl_color_14 },
	["S"] = { "S-LINE", colors.fl_color_14 },
	[""] = { "S-BLOCK", colors.fl_color_14 },
	["c"] = { "COMMAND", colors.fl_color_3 },
	["cv"] = { "COMMAND", colors.fl_color_3 },
	["ce"] = { "COMMAND", colors.fl_color_3 },
	["r"] = { "PROMPT", colors.fl_color_15 },
	["rm"] = { "MORE", colors.fl_color_15 },
	["r?"] = { "CONFIRM", colors.fl_color_15 },
	["!"] = { "SHELL", colors.fl_color_7 },
}

-- local sid_mode_hl = function()
-- 	return {
-- 		fg = mode_colors[vim.fn.mode()][2],
-- 		bg = colors.lightbg,
-- 	}
-- end

-- components.active[1][1] = {
-- 	provider = function()
-- 		return " " .. mode_colors[vim.fn.mode()][1] .. " "
-- 	end,
-- 	hl = chad_mode_hl,
-- }

components.active[1][1] = {
	provider = "██",
	-- return '██ '
	enabled = enable_only_in_full_buf,
	hl = function()
		return {
			fg = mode_colors[vim.fn.mode()][2],
			bg = mode_colors[vim.fn.mode()][2],
		}
	end,
}

components.active[1][2] = {
	provider = "git_branch",
	enabled = enable_only_in_full_buf,
	hl = {
		fg = colors.fl_color_16,
		bg = colors.fl_color_9,
	},
	icon = "  ",
	right_sep = {
		str = icon_styles.default2.right,
		hl = {
			fg = colors.fl_color_9,
			bg = colors.fl_color_16,
		},
	},
}

components.active[1][3] = {
	provider = function()
		local origFilename = vim.fn.expand("%:t")
        local function splitLongString(originalNameString, maxLineLength)
            local length = #originalNameString
            if length > maxLineLength then
                return ""
            else
                return originalNameString
            end
        end
        local filename = splitLongString(origFilename, 15)
		local extension = vim.fn.expand("%:e")
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			icon = "  "
			return icon
		end
		return " " .. icon .. " " .. filename .. " "
	end,
	enabled = enable_only_in_full_buf,
	hl = {
		fg = colors.fl_color_8,
		bg = colors.fl_color_16,
	},

	right_sep = {
		str = icon_styles.default2.right,
		hl = {
			fg = colors.fl_color_16,
			bg = colors.fl_color_8,
		},
	},
}

components.active[1][4] = {
	provider = "git_diff_added",
	hl = { fg = colors.fl_color_1, bg = colors.fl_color_8 },
	icon = "  ",
}
-- diffModfified
components.active[1][5] = {
	provider = "git_diff_changed",
	hl = { fg = colors.fl_color_7, bg = colors.fl_color_8 },
	icon = " ⦿ ",
}
-- diffRemove
components.active[1][6] = {
	provider = "git_diff_removed",
	hl = { fg = colors.vc_remove, bg = colors.fl_color_8 },
	icon = "  ",
}

-- components.active[1][7] = {
-- 	provider = icon_styles.slant.right,
-- 	-- TODO:
-- 	-- enabled = function()
-- 	--         local b = vim.b
-- 	--         local g = vim.k
-- 	-- 	return g.gitsigns_head or b.gitsigns_head or b.gitsigns_status_dict	end,
-- 	hl = {
-- 		fg = colors.fl_color_8,
-- 		bg = colors.fl_color_8,
-- 	},
-- }

--=====================================================
--                  center
--=====================================================

components.active[2][1] = {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]
		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = {
				"⠋",
				"⠇",
				"⠦",
				"⠙",
				"⠹",
				"⠼",
				"⠴",
				"⠸",
				"⠦",
				"⠧",
				"⠇",
				"⠏",
			}

			local success_icon = {
				-- "",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
				"﫠",
			}

			local ms = vim.loop.hrtime() / 1000000
			local frame = math.floor(ms / 120) % #spinners

			if percentage >= 70 then
				return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
			else
				return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
			end
		end
		return "%b-0x%B"
	end,
	enabled = enable_only_in_full_buf,
	hl = { fg = colors.fl_color_1, bg = colors.fl_color_8 },
}

--=====================================================
--                  right
--=====================================================
-- some custom manipulation
components.active[3][1] = {
	provider = icon_styles.slant.left,
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
			or lsp.diagnostics_exist(lsp_severity.WARN)
			or lsp.diagnostics_exist(lsp_severity.HINT)
			or lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = {
		fg = colors.fl_color_8,
		bg = colors.fl_color_8,
	},
}

components.active[3][2] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,
	hl = { fg = colors.vc_remove, bg = colors.fl_color_8 },
	icon = "  ",
}

components.active[3][3] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = { fg = colors.fl_color_4, bg = colors.fl_color_8 },
	icon = "  ",
}

components.active[3][4] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = { fg = colors.fl_color_6, bg = colors.fl_color_8 },
	icon = "  ",
}

components.active[3][5] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = { fg = colors.fl_color_1, bg = colors.fl_color_8 },
	icon = "  ",
}

-- some custom manipulation
components.active[3][6] = {
	provider = " ",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
			or lsp.diagnostics_exist(lsp_severity.WARN)
			or lsp.diagnostics_exist(lsp_severity.HINT)
			or lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = {
		fg = colors.fl_color_8,
		bg = colors.fl_color_8,
	},
}

components.active[3][7] = {
	provider = icon_styles.default.left,
	enabled = enable_only_in_full_buf,
	hl = {
		fg = colors.fl_color_16,
		bg = colors.fl_color_8,
	},
}

components.active[3][7] = {
	provider = function()
		local lsp_symbol_str = "  LSP"
		if next(vim.lsp.buf_get_clients()) ~= nil then
			local lsp_status_slant = " " .. lsp_symbol_str .. " " .. icon_styles.default.left
			return lsp_status_slant
		else
			return ""
		end
	end,
	enabled = enable_only_in_full_buf,
	hl = { fg = colors.fl_color_9, bg = colors.fl_color_16 },
	left_sep = {
		str = icon_styles.default.left,
		hl = {
			fg = colors.fl_color_16,
			bg = colors.fl_color_8,
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
		fg = colors.fl_color_1,
		bg = colors.fl_color_9,
	},
}

components.active[3][9] = {
	provider = "scroll_bar",
	enabled = enable_only_in_full_buf,
	hl = {
		fg = colors.fl_color_15,
		bg = colors.fl_color_9,
		style = "bold",
	},
}

require("feline").setup({
	colors = {
		bg = colors.fl_color_8,
		fg = colors.fl_color_16,
	},
	components = components,
	force_inactive = {
		filetypes = {
			"^NvimTree$",
			"^Outline$",
		},
		buftypes = {
			"^terminal$",
		},
		bufnames = {
        },
	},
})
